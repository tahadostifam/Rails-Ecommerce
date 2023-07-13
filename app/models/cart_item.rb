class CartItem < ApplicationRecord
  belongs_to :session
  belongs_to :product
end
