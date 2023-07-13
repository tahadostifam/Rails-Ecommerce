class CreatePaymentDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_details do |t|
      t.references :order_detail
      t.integer :amount
      t.string :status, # done | failed | unknown
      t.timestamps
    end
  end
end
