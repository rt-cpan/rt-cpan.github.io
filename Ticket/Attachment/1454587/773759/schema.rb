# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140125205141) do

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "latin_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

  add_index "cities", ["latin_name"], name: "index_cities_on_latin_name", unique: true

  create_table "countries", force: true do |t|
    t.string "name"
    t.string "latin_name"
  end

  add_index "countries", ["latin_name"], name: "index_countries_on_latin_name", unique: true

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "details", force: true do |t|
    t.integer "order_id"
    t.integer "dish_id"
    t.integer "count"
    t.float   "price",    default: 0.0, null: false
  end

  create_table "devices", force: true do |t|
    t.string   "name"
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discounts", force: true do |t|
    t.string   "name"
    t.integer  "discount"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "every"
  end

  create_table "discounts_dishes", force: true do |t|
    t.integer "discount_id"
    t.integer "dish_id"
  end

  create_table "dishes", force: true do |t|
    t.integer  "restaurant_id"
    t.string   "name"
    t.text     "desc"
    t.string   "image"
    t.boolean  "available"
    t.integer  "section_id"
    t.float    "price",                default: 0.0, null: false
    t.integer  "sort_by"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "divisions", force: true do |t|
    t.string   "name"
    t.string   "latin_name"
    t.integer  "restaurant_id"
    t.integer  "sort_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "employees", force: true do |t|
    t.integer  "user_id"
    t.integer  "status_id"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gritter_notices", force: true do |t|
    t.integer  "owner_id",     null: false
    t.string   "owner_type",   null: false
    t.text     "text",         null: false
    t.text     "options",      null: false
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gritter_notices", ["owner_id", "delivered_at"], name: "index_gritter_notices_on_owner_id_and_delivered_at"

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.integer  "measure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredients", ["measure_id"], name: "index_ingredients_on_measure_id"

  create_table "main_menu_items", force: true do |t|
    t.string   "name",       default: ""
    t.string   "route"
    t.integer  "seq",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "measures", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.float    "sum"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "table_id"
    t.integer  "status_id"
    t.integer  "device_id"
    t.integer  "discount_id"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "recipes", force: true do |t|
    t.integer  "dish_id"
    t.integer  "ingredient_id"
    t.float    "quantity"
    t.integer  "measure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipes", ["dish_id"], name: "index_recipes_on_dish_id"
  add_index "recipes", ["ingredient_id"], name: "index_recipes_on_ingredient_id"
  add_index "recipes", ["measure_id"], name: "index_recipes_on_measure_id"

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "latin_name"
    t.text     "check_header"
    t.text     "check_footer"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code"
    t.datetime "menu_updated_at"
    t.integer  "fallback_table_id"
    t.integer  "internet_table_id"
  end

  add_index "restaurants", ["code"], name: "index_restaurants_on_code", unique: true
  add_index "restaurants", ["latin_name"], name: "index_restaurants_on_latin_name", unique: true

  create_table "restaurants_users", force: true do |t|
    t.integer "restaurant_id"
    t.integer "user_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name",       default: "", null: false
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true

  create_table "sections", force: true do |t|
    t.string  "name"
    t.string  "latin_name"
    t.integer "section_id"
    t.integer "restaurant_id"
    t.integer "sort_by"
    t.string  "image"
    t.integer "division_id"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

  create_table "table_statuses", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tables", force: true do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.string   "name",            default: "",    null: false
    t.string   "device"
    t.boolean  "busy",            default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "table_status_id"
    t.boolean  "server",          default: false
  end

  add_index "tables", ["name"], name: "index_tables_on_name"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.string   "last_name"
    t.string   "first_name"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["login"], name: "index_users_on_login", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
