class PhoneOtp < ApplicationRecord
  EXPIRE_TIME = 2.minutes

  before_save :init_default_values

  validates :phone_number, presence: true

  def expired?
    Time.now > expires_at
  end

  def generate_otp_code
    rand(100000..999999).to_s
  end

  def generate_expires_at
    Time.now + EXPIRE_TIME
  end

  private

  def init_default_values
    self.otp_code = generate_otp_code
    self.expires_at = generate_expires_at
  end
end
