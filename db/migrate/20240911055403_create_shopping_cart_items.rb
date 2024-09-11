class CreateShoppingCartItems < ActiveRecord::Migration[7.2]
  def change
    create_table :shopping_cart_items do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :order_id

      t.timestamps
    end
  end
end
