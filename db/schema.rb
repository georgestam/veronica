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

ActiveRecord::Schema.define(version: 20170320090300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title",                      null: false
    t.string   "description",                null: false
    t.string   "locale",                     null: false
    t.string   "slug",                       null: false
    t.boolean  "private",     default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "photo"
  end

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "availabilities", force: :cascade do |t|
    t.string   "weekday"
    t.time     "start"
    t.time     "finish"
    t.integer  "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_availabilities_on_car_id", using: :btree
  end

  create_table "cars", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "bio"
    t.string   "video_url"
    t.string   "travel_distance"
    t.string   "price_hour"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_cars_on_user_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "imparted_hours", force: :cascade do |t|
    t.integer  "minutes",     null: false
    t.datetime "date"
    t.integer  "price_cents", null: false
    t.integer  "journey_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["journey_id"], name: "index_imparted_hours_on_journey_id", using: :btree
  end

  create_table "journeys", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "car_id"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "completed"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "duration"
    t.string   "payment"
    t.datetime "pick_up_time"
    t.integer  "seats_available"
    t.index ["car_id"], name: "index_journeys_on_car_id", using: :btree
    t.index ["user_id"], name: "index_journeys_on_user_id", using: :btree
  end

  create_table "passengers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "journey_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "driver_rating"
    t.integer  "passenger_rating"
    t.text     "driver_review"
    t.text     "passenger_review"
    t.index ["journey_id"], name: "index_passengers_on_journey_id", using: :btree
    t.index ["user_id"], name: "index_passengers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.text     "description"
    t.string   "gender"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "country"
    t.string   "linkedin_url"
    t.string   "facebook_url"
    t.string   "bank_account"
    t.datetime "date_of_birth"
    t.boolean  "passport_verif"
    t.boolean  "interview_verif"
    t.boolean  "linkedin_verif"
    t.boolean  "facebook_verif"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "admin",                             default: false, null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "authentication_token",   limit: 30
    t.string   "domain"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "availabilities", "cars"
  add_foreign_key "cars", "users"
  add_foreign_key "imparted_hours", "journeys"
  add_foreign_key "journeys", "cars"
  add_foreign_key "journeys", "users"
  add_foreign_key "passengers", "journeys"
  add_foreign_key "passengers", "users"
end
