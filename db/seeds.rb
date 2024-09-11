User.create([
  {
    name: "John Doe",
    email: "john_doe@mail.com",
    password: "12345678",
    location: "DC",
    city: "USA"
  }
])

Category.create([
  { name: "Sample Category" }
])

Product.create([
  { name: "Apple", price: 0.99, description: "A delicious fruit" },
  { name: "Banana", price: 0.75, description: "A yellow fruit" },
  { name: "Orange", price: 1.25, description: "A citrus fruit" }
])

category = Category.find 1
product = Product.find 1

product.categories += [ category ]
