class Product < ApplicationRecord
  references :category
  has_many :discounts
end
