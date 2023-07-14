require "dry-schema"

LoginByUsernameSchema = Dry::Schema.Params do
  required(:username).filled(:string)
  required(:password).filled(:string)
end
