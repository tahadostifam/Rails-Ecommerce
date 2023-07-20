class CartItem < ApplicationRecord
  belongs_to :session
  belongs_to :product

  validates :session, :product, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }, allow_blank: false
  validates :product, uniqueness: true

  # This method is used to convert the `cart_item` object into a JSON representation.
  def as_json(options = {})
    super(
      options.merge({
        include: {
          product: {
            except: [
              :created_at,
              :updated_at,
              :category_id,
              :quantity
            ]
          },
        },
        except: [:product_id, :session_id]
      })
    )
  end
end
