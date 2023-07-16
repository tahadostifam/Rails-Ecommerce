require "dry-schema"

CreateProductSchema = Dry::Schema.Params do
  required(:name).filled(:string)
  required(:desc).filled(:string)
  required(:price).filled(:decimal)
  required(:quantity).filled(:integer)
  required(:category_id).filled(:integer)
  required(:discount_id).maybe(:integer)
end

UpdateProductSchema = Dry::Schema.Params do
  required(:id).filled(:integer)
  required(:name).filled(:string)
  required(:desc).filled(:string)
  required(:price).filled(:decimal)
  required(:quantity).filled(:integer)
  required(:category_id).filled(:integer)
  required(:discount_id).maybe(:integer)
end
