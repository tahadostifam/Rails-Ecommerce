class CartPresenter
  def self.to_json(cart_items)
    items = cart_items.map do |i|
      i.as_json(include: {
        product: {
          include: {
            discounts: { only: [:name, :discount_percent] } },
            except: [:created_at, :updated_at, :category_id, :discount_id]
          }
        }
      )
    end

    items.map { |i| i.delete("product_id") }
    items.map { |i| i.delete("session_id") }

    return items
  end
end
