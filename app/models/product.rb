class Product < ApplicationRecord
  belongs_to :category

  validates :name, :desc, :price, :quantity, presence: true
end
