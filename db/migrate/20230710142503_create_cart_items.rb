class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      # An item of cart.

      t.integer :quantity, null: false
      t.references :session
      t.references :product
    end
  end
end
