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

ActiveRecord::Schema[7.2].define(version: 2024_12_14_211406) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chef_profile_id", null: false
    t.datetime "date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "time"
    t.integer "guests"
    t.text "special_requests"
    t.index ["chef_profile_id"], name: "index_bookings_on_chef_profile_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "chef_availabilities", force: :cascade do |t|
    t.integer "chef_profile_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chef_profile_id"], name: "index_chef_availabilities_on_chef_profile_id"
  end

  create_table "chef_profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "bio"
    t.string "specialty"
    t.integer "experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "years_of_experience"
    t.text "cuisine_types"
    t.integer "profile_completion_step", default: 0
    t.decimal "wallet_balance"
    t.string "availability"
    t.index ["user_id"], name: "index_chef_profiles_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "quantity"
    t.integer "menu_item_id", null: false
    t.string "unit"
    t.index ["menu_item_id"], name: "index_ingredients_on_menu_item_id"
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer "chef_profile_id", null: false
    t.string "name"
    t.text "description"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chef_profile_id"], name: "index_menu_items_on_chef_profile_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chef_profile_id", null: false
    t.integer "rating"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chef_profile_id"], name: "index_reviews_on_chef_profile_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount"
    t.string "transaction_type"
    t.integer "chef_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chef_profile_id"], name: "index_transactions_on_chef_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "chef_profiles"
  add_foreign_key "bookings", "users"
  add_foreign_key "chef_availabilities", "chef_profiles"
  add_foreign_key "chef_profiles", "users"
  add_foreign_key "ingredients", "menu_items"
  add_foreign_key "ingredients", "recipes"
  add_foreign_key "menu_items", "chef_profiles"
  add_foreign_key "reviews", "chef_profiles"
  add_foreign_key "reviews", "users"
  add_foreign_key "transactions", "chef_profiles"
end
