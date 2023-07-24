class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.decimal :total
      t.references :user
      t.references :payment_detail
    end
  end
end
