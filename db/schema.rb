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


ActiveRecord::Schema.define(version: 20160829145331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "make"
    t.string   "name"
    t.string   "vrn"
    t.string   "colour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cars_on_user_id", using: :btree
  end

  create_table "journeys", force: :cascade do |t|
    t.integer  "seats_available"
    t.integer  "user_id"
    t.integer  "car_id"
    t.datetime "pick_up_time"
    t.string   "pick_up_location"
    t.string   "drop_off_location"
    t.boolean  "completed"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["car_id"], name: "index_journeys_on_car_id", using: :btree
    t.index ["user_id"], name: "index_journeys_on_user_id", using: :btree
  end

  create_table "passengers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "journey_id"
    t.integer  "driver_rating"
    t.integer  "passenger_rating"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["journey_id"], name: "index_passengers_on_journey_id", using: :btree
    t.index ["user_id"], name: "index_passengers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.text     "description"
    t.string   "gender"
    t.datetime "date_of_birth"
    t.string   "music_habits"
    t.string   "speaking_habits"
    t.integer  "year_of_study"
    t.string   "uni_course"
    t.boolean  "smoking"
    t.string   "phone_number"
    t.string   "student_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "cars", "users"
  add_foreign_key "journeys", "cars"
  add_foreign_key "journeys", "users"
  add_foreign_key "passengers", "journeys"
  add_foreign_key "passengers", "users"
end
