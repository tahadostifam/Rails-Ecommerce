class PaymentDetail < ApplicationRecord
  has_many :order_details
end
