require "dry-schema"

LoginByUsernameSchema = Dry::Schema.Params do
  required(:username).filled(:string)
  required(:password).filled(:string)
end

SignupSchema = Dry::Schema.Params do
  required(:name).filled(:string)
  required(:last_name).filled(:string)
  required(:phone_number).filled(:string, min_size?: 11)
  required(:username).filled(:string, min_size?: 6)
  required(:password).filled(:string, min_size?: 8)
end
