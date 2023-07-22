user = User.create!(
  name: "John",
  last_name: "Doe",
  username: "john_doe",
  phone_number: "+989368392346",
  password: "1234@Doe",
  is_confirmed: true,
  access: {
    :role => :seller,
    :list => {
      :product => [:create, :update, :delete]
    }
  }
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
