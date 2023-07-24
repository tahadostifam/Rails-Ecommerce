class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
       # Stores cart total price.

      t.decimal :total, default: 0
      t.references :user
    end
  end
end
