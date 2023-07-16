config = Rails.application.config_for(:sms_client).symbolize_keys

class SmsClient
  def self.send_otp_code(phone_number, code)
    puts "Method not implement yet!"
  end
end
