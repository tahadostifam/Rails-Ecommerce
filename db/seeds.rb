user = User.create!(
  name: "John",
  last_name: "Doe",
  username: "john_doe",
  phone_number: "+989368392346",
  password: "1234@Doe",
  confirmed: false,
  role: :user
)

admin = User.create!(
  name: "Admin",
  last_name: "Admin",
  username: "admin",
  phone_number: "+989368392347",
  password: "4321@Admin",
  confirmed: true,
  role: :admin
)

seller = User.create!(
  name: "Seller",
  last_name: "Seller",
  username: "seller",
  phone_number: "+989368392348",
  password: "4321@Seller",
  confirmed: true,
  role: :seller
)

category = Category.create!(
  name: "Category1"
)

product = Product.create!(
  name: "Sample1",
  desc: "sample description",
  price: 10,
  quantity: 3,
  category_id: category.id,
)

discount = Discount.create!(
  name: "Sample Discount 1",
  discount_percent: 5,
  expires_at: Time.now + 2.days
)

# Making a sample cart! :
session = Session.create!(user_id: user.id)

cart_items = CartItem.create!([{ quantity: 1, product_id: product.id, session_id: session.id }])
