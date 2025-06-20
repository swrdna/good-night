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

ActiveRecord::Schema[7.2].define(version: 2025_06_17_013802) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sleep_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "start_time", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.index ["user_id"], name: "index_sleep_sessions_on_user_id"
  end

  create_table "user_follows", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_user_follows_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_user_follows_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_user_follows_on_follower_id"
    t.check_constraint "follower_id <> followed_id", name: "follower_cannot_follow_self"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "sleep_sessions", "users"
  add_foreign_key "user_follows", "users", column: "followed_id"
  add_foreign_key "user_follows", "users", column: "follower_id"
end
