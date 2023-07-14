class User < ApplicationRecord
  has_many :sessions

  has_secure_password

  def confirmed?
    is_confirmed
  end

  def unconfirmed?
    !is_confirmed
  end
end
