class User < ApplicationRecord
  has_many :sessions
  has_one :account_detail

  after_save :create_account_detail

  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}\z/

  has_secure_password

  validates :name, :last_name, :username, :phone_number, presence: true
  validates :password, presence: true, on: [:create]
  validates :password, presence: true, on: [:update], if: :password_digest_changed?
  validates :username, :phone_number, uniqueness: true
  validates :password, format: { with: PASSWORD_REGEX, message: "must be at least 8 characters long and include at least one lowercase letter, one uppercase letter, and one digit" }, if: :password_digest_changed?

  def confirmed?
    confirmed
  end

  def locked?
    locked
  end

  def unconfirmed?
    !confirmed?
  end

  def confirm!
    self.confirmed = true
  end

  def unconfirm!
    self.confirmed = false
  end

  def role?(role_name)
    return self.role == role_name
  end

  private

  def create_account_detail
    unless AccountDetail.find_by(id: self.id)
      AccountDetail.create!(user_id: self.id)
    end
  end
end
