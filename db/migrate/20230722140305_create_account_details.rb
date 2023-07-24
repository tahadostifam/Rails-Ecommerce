class CreateAccountDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :account_details do |t|
      t.string :address1
      t.string :address2
      t.string :postal_code

      t.references :user
    end
  end
end
