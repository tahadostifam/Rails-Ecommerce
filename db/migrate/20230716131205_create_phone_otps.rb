class CreatePhoneOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_otps do |t|
      t.string :phone_number, null: false
      t.integer :otp_code, null: false
      t.datetime :expires_at, null: false

      t.index :phone_number, unique: true
    end
  end
end
