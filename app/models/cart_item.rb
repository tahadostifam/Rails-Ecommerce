class CartItem < ApplicationRecord
  belongs_to :session
  belongs_to :product

  validates :session, :product, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }, allow_blank: false
  validates :product, uniqueness: true
end
