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

ActiveRecord::Schema[7.0].define(version: 2023_08_02_022801) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoices", force: :cascade do |t|
    t.date "order_date"
    t.string "billed_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_number", default: 10000
    t.integer "shipping_fee", default: 0
    t.integer "discount", default: 0
  end

  create_table "products", force: :cascade do |t|
    t.string "sku"
    t.string "name"
    t.integer "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_id"
    t.boolean "sold", default: false
    t.integer "quantity"
    t.index ["invoice_id"], name: "index_products_on_invoice_id"
  end

  add_foreign_key "products", "invoices"
end
