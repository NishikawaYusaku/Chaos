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

ActiveRecord::Schema[7.1].define(version: 2024_04_08_053240) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "vtuber_id", null: false
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["vtuber_id"], name: "index_comments_on_vtuber_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "vtuber_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "vtuber_id"], name: "index_favorites_on_user_id_and_vtuber_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
    t.index ["vtuber_id"], name: "index_favorites_on_vtuber_id"
  end

  create_table "frequencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  create_table "vtuber_contents", force: :cascade do |t|
    t.bigint "vtuber_id"
    t.bigint "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_vtuber_contents_on_content_id"
    t.index ["vtuber_id"], name: "index_vtuber_contents_on_vtuber_id"
  end

  create_table "vtuber_places", force: :cascade do |t|
    t.bigint "vtuber_id"
    t.bigint "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["place_id"], name: "index_vtuber_places_on_place_id"
    t.index ["vtuber_id"], name: "index_vtuber_places_on_vtuber_id"
  end

  create_table "vtuber_tags", force: :cascade do |t|
    t.bigint "vtuber_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_vtuber_tags_on_tag_id"
    t.index ["vtuber_id", "tag_id"], name: "index_vtuber_tags_on_vtuber_id_and_tag_id", unique: true
    t.index ["vtuber_id"], name: "index_vtuber_tags_on_vtuber_id"
  end

  create_table "vtuber_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "vtuber_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vtuber_users_on_user_id"
    t.index ["vtuber_id"], name: "index_vtuber_users_on_vtuber_id"
  end

  create_table "vtubers", force: :cascade do |t|
    t.string "name", null: false
    t.string "image"
    t.date "debut_date"
    t.string "fan_name"
    t.string "like"
    t.string "unlike"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "frequency_id"
    t.string "gender"
    t.string "name_x"
    t.string "affiliation"
    t.date "birthday"
    t.index ["frequency_id"], name: "index_vtubers_on_frequency_id"
    t.index ["name"], name: "index_vtubers_on_name", unique: true
  end

  add_foreign_key "comments", "users"
  add_foreign_key "comments", "vtubers"
  add_foreign_key "favorites", "users"
  add_foreign_key "favorites", "vtubers"
  add_foreign_key "vtuber_contents", "contents"
  add_foreign_key "vtuber_contents", "vtubers"
  add_foreign_key "vtuber_places", "places"
  add_foreign_key "vtuber_places", "vtubers"
  add_foreign_key "vtuber_tags", "tags"
  add_foreign_key "vtuber_tags", "vtubers"
  add_foreign_key "vtuber_users", "users"
  add_foreign_key "vtuber_users", "vtubers"
  add_foreign_key "vtubers", "frequencies"
end
