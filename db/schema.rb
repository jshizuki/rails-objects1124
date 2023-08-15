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

ActiveRecord::Schema[7.0].define(version: 2023_08_15_160423) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "objects_invoices", force: :cascade do |t|
    t.date "order_date"
    t.string "billed_to"
    t.integer "invoice_number"
    t.integer "shipping_fee", default: 0
    t.string "discount_type"
    t.integer "discount_input", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "objects_products", force: :cascade do |t|
    t.string "sku"
    t.string "name"
    t.integer "unit_price"
    t.boolean "sold", default: false
    t.integer "quantity"
    t.bigint "objects_invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["objects_invoice_id"], name: "index_objects_products_on_objects_invoice_id"
  end

  add_foreign_key "objects_products", "objects_invoices"
end
