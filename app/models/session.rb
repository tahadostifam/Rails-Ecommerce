class Session < ApplicationRecord
  references :user
  has_many :cart_items

  def compute_total
    total = 0

    items = self.cart_items
    items.each do |i|
      total += i.product.price * i.quantity
    end

    self.total = total
  end
end
