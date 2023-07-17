AddItemToCartSchema = Dry::Schema.Params do
  required(:product_id).filled(:integer)
  required(:quantity).filled(:integer)
end

RemoveCartItem = Dry::Schema.Params do
  required(:item_id).filled(:integer)
end
