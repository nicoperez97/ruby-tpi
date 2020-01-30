# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200130180941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.integer "cuil"
    t.string "nombre"
    t.integer "condicion"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "estado"
    t.bigint "product_id"
    t.bigint "reservation_id"
    t.bigint "sell_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["reservation_id"], name: "index_items_on_reservation_id"
    t.index ["sell_id"], name: "index_items_on_sell_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "codigo"
    t.string "descripcion"
    t.string "detalle"
    t.integer "montoU"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_items", force: :cascade do |t|
    t.bigint "reservation_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_reservation_items_on_item_id"
    t.index ["reservation_id"], name: "index_reservation_items_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "fecha"
    t.bigint "client_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "sell_items", force: :cascade do |t|
    t.bigint "sell_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_sell_items_on_item_id"
    t.index ["sell_id"], name: "index_sell_items_on_sell_id"
  end

  create_table "sells", force: :cascade do |t|
    t.date "fecha"
    t.bigint "client_id"
    t.bigint "user_id"
    t.bigint "reservation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_sells_on_client_id"
    t.index ["reservation_id"], name: "index_sells_on_reservation_id"
    t.index ["user_id"], name: "index_sells_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "us"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "items", "products"
  add_foreign_key "items", "reservations"
  add_foreign_key "items", "sells"
  add_foreign_key "reservation_items", "items"
  add_foreign_key "reservation_items", "reservations"
  add_foreign_key "reservations", "clients"
  add_foreign_key "reservations", "users"
  add_foreign_key "sell_items", "items"
  add_foreign_key "sell_items", "sells"
  add_foreign_key "sells", "clients"
  add_foreign_key "sells", "reservations"
  add_foreign_key "sells", "users"
end
