class User < ApplicationRecord
  serialize :access, Hash
  has_many :sessions
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}\z/

  has_secure_password

  after_initialize :init_default_access

  validates :name, :last_name, :username, :phone_number, :access, presence: true
  validates :password, presence: true, on: [:create]
  validates :password, presence: true, on: [:update], if: :password_digest_changed?
  validates :username, :phone_number, uniqueness: true
  validates :password, format: { with: PASSWORD_REGEX, message: "must be at least 8 characters long and include at least one lowercase letter, one uppercase letter, and one digit" }, if: :password_digest_changed?

  def confirmed?
    is_confirmed
  end

  def unconfirmed?
    !is_confirmed
  end


  # This method is used to convert the `user` object into a JSON representation.
  def as_json(options = {})
    super(options.merge({
      except: [:password, :password_digest, :created_at, :updated_at]
    }))
  end

  private

  def init_default_access
    self.access = {
      :role => :user,
      :list => nil
    }
  end
end
