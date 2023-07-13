class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :desc
      t.decimal :price
      t.integer :quantity

      t.references :discount
      t.references :category

      t.timestamps
    end
  end
end
