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

ActiveRecord::Schema.define(version: 2021_04_20_114739) do

  create_table "costs", force: :cascade do |t|
    t.string "user_id"
    t.integer "order_id"
    t.integer "price"
    t.string "out_flug"
    t.string "bank_name"
    t.string "bank_type"
    t.string "bank_number"
    t.string "bank_user_name_sei"
    t.string "bank_user_name_mei"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_costs_on_order_id"
    t.index ["user_id"], name: "index_costs_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "order_id"
    t.string "user_id"
    t.string "card_id"
    t.string "buysell_flug"
    t.integer "price"
    t.string "orderdate"
    t.string "out_flug"
    t.string "delete_flug"
    t.string "out_user_id"
    t.string "shipment_flug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_orders_on_order_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "card_id"
    t.string "card_name"
    t.string "category"
    t.string "shuuroku"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "user_id"
    t.string "postalcode"
    t.string "city"
    t.string "adress"
    t.string "building"
    t.string "sei_kana"
    t.string "sei_kanzi"
    t.string "mei_kana"
    t.string "mei_kanzi"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
