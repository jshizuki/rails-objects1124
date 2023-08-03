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

ActiveRecord::Schema[7.0].define(version: 2023_08_03_171650) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.date "order_date"
    t.string "billed_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "objects_invoices", force: :cascade do |t|
    t.date "order_date"
    t.string "billed_to"
    t.integer "invoice_number"
    t.integer "shipping_fee", default: 0
    t.integer "discount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "objects_products", force: :cascade do |t|
    t.string "sku"
    t.string "name"
    t.integer "unit_price"
    t.boolean "sold", default: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "objects_invoice_id"
    t.index ["objects_invoice_id"], name: "index_objects_products_on_objects_invoice_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "sku"
    t.string "name"
    t.integer "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tmanager_tasks", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wlist_bookmarks", force: :cascade do |t|
    t.string "comment"
    t.bigint "wlist_movie_id", null: false
    t.bigint "wlist_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wlist_list_id"], name: "index_wlist_bookmarks_on_wlist_list_id"
    t.index ["wlist_movie_id"], name: "index_wlist_bookmarks_on_wlist_movie_id"
  end

  create_table "wlist_lists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wlist_movies", force: :cascade do |t|
    t.string "title"
    t.text "overview"
    t.string "poster_url"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wlist_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_wlist_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_wlist_users_on_reset_password_token", unique: true
  end

  add_foreign_key "objects_products", "objects_invoices"
  add_foreign_key "wlist_bookmarks", "wlist_lists"
  add_foreign_key "wlist_bookmarks", "wlist_movies"
end
