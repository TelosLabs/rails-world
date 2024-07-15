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

ActiveRecord::Schema[7.1].define(version: 2024_07_10_213305) do
  create_table "conferences", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.integer "location_id", null: false
    t.integer "conference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_events_on_conference_id"
    t.index ["location_id"], name: "index_events_on_location_id"
  end

  create_table "events_speakers", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "speaker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "speaker_id"], name: "index_events_speakers_on_event_id_and_speaker_id", unique: true
    t.index ["event_id"], name: "index_events_speakers_on_event_id"
    t.index ["speaker_id"], name: "index_events_speakers_on_speaker_id"
  end

  create_table "events_tags", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "tag_id"], name: "index_events_tags_on_event_id_and_tag_id", unique: true
    t.index ["event_id"], name: "index_events_tags_on_event_id"
    t.index ["tag_id"], name: "index_events_tags_on_tag_id"
  end

  create_table "events_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_events_users_on_event_id"
    t.index ["user_id", "event_id"], name: "index_events_users_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_events_users_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "conference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_locations_on_conference_id"
    t.index ["name", "conference_id"], name: "index_locations_on_name_and_conference_id", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "bio"
    t.string "location"
    t.string "github_url"
    t.string "linkedin_url"
    t.string "twitter_url"
    t.boolean "is_public", default: false, null: false
    t.string "profileable_type", null: false
    t.integer "profileable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["profileable_type", "profileable_id"], name: "index_profiles_on_profileable"
    t.index ["uuid"], name: "index_profiles_on_uuid", unique: true
  end

  create_table "speakers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "role"
    t.boolean "mail_notifications_enabled", default: true, null: false
    t.boolean "in_app_notifications_enabled", default: true, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "events", "conferences"
  add_foreign_key "events", "locations"
  add_foreign_key "events_speakers", "events"
  add_foreign_key "events_speakers", "speakers"
  add_foreign_key "events_tags", "events"
  add_foreign_key "events_tags", "tags"
  add_foreign_key "events_users", "events"
  add_foreign_key "events_users", "users"
  add_foreign_key "locations", "conferences"
end
