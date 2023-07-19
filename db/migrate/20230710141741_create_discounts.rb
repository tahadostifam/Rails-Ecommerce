class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.string :name, null: false
      t.decimal :discount_percent, null: false
      t.date :expires_at, null: false
    end
  end
end
