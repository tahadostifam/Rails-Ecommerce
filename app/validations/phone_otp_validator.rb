require "dry-schema"

LoginByPhoneSchema = Dry::Schema.Params do
  required(:phone_number).filled(:string)
end

VerifyOtpCodeSchema = Dry::Schema.Params do
  required(:phone_number).filled(:string)
  required(:otp_code).filled(:integer)
end
