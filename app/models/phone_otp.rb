class PhoneOtp < ApplicationRecord
  EXPIRE_TIME = 2.minutes

  def expired?
    Time.now > expires_at
  end

  def self.generate_otp_code
    rand(100000..999999).to_s
  end

  def self.generate_expires_at
    Time.now + EXPIRE_TIME
  end
end
