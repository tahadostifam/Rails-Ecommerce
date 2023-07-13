class Session < ApplicationRecord
  references :user
  has_many :cart_items
end
