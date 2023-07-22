json.msg "Success"

json.detail do
  json.array! @products do |item|
    json.id item.id
    json.name item.name
    json.desc item.desc
    json.price item.price
    json.quantity item.quantity
    json.category do
      json.id item.category.id
      json.name item.category.name
    end
  end
end
