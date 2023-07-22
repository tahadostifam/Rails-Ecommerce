json.msg "Success"

json.detail do
  json.items do
    json.array! @items do |item|
      json.id item.id
      json.quantity item.quantity
      json.product do
        json.id item.product.id
        json.name item.product.name
        json.desc item.product.desc
        json.price item.product.price
      end
    end
  end
end
