user = User.create!(
  name: "John",
  last_name: "Doe",
  username: "john_doe",
  phone_number: "+989368392346",
  password: "1234",
  is_customer: true,
)

category = Category.create!(
  name: "Category1",
  is_available: true,
)

product = Product.create!(
  name: "Sample1",
  desc: "sample description",
  price: 10,
  quantity: 3,
  category_id: category.id,
)

# Making a sample cart! :
session = Session.create!(user_id: user.id)

cart_items = CartItem.create!([{ quantity: 1, product_id: product.id, session_id: session.id }])
