class CategoriesProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :categories_products do |t|
      t.references :product
      t.references :category
    end
  end
end
