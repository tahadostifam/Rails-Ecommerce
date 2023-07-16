# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_16_131205) do
  create_table "cart_items", force: :cascade do |t|
    t.integer "quantity", null: false
    t.integer "session_id"
    t.integer "product_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
    t.index ["session_id"], name: "index_cart_items_on_session_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.boolean "is_available"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "discount_percent", null: false
    t.date "expires_at", null: false
    t.integer "product_id"
    t.index ["product_id"], name: "index_discounts_on_product_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.decimal "total"
    t.integer "user_id"
    t.integer "payment_detail_id"
    t.index ["payment_detail_id"], name: "index_order_details_on_payment_detail_id"
    t.index ["user_id"], name: "index_order_details_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_detail_id"
    t.integer "product_id"
    t.index ["order_detail_id"], name: "index_order_items_on_order_detail_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "payment_details", force: :cascade do |t|
    t.integer "order_detail_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "#<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x00007f128b68bba0>"
    t.index ["order_detail_id"], name: "index_payment_details_on_order_detail_id"
  end

  create_table "phone_otps", force: :cascade do |t|
    t.string "phone_number", null: false
    t.integer "otp_code", null: false
    t.datetime "expires_at", null: false
    t.index ["phone_number"], name: "index_phone_otps_on_phone_number"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.decimal "price"
    t.integer "quantity"
    t.integer "discount_id"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["discount_id"], name: "index_products_on_discount_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.decimal "total", default: "0.0"
    t.integer "user_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "username", null: false
    t.string "password_digest"
    t.string "phone_number", null: false
    t.string "address1"
    t.string "address2"
    t.string "postal_code"
    t.boolean "is_customer", default: false
    t.boolean "is_confirmed", default: false
    t.boolean "is_banned", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
