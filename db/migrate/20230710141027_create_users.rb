class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.string :username, null: false
      t.string :password_digest
      t.string :phone_number, null: false
      t.string :address1
      t.string :address2
      t.string :postal_code

      t.text :access

      t.boolean :is_confirmed, default: false
      t.boolean :is_banned, default: false

      t.timestamps

      t.index [:username, :phone_number], unique: true
    end
  end
end
