class Session < ApplicationRecord
  references :user
  has_many :cart_items

  ##
  # The function computes the total cost of items in a shopping cart.
  def compute_total
    total = 0

    items = self.cart_items
    items.each do |i|
      total += i.product.price * i.quantity
    end

    self.total = total
  end
end
