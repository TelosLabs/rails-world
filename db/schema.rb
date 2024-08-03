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

ActiveRecord::Schema[7.1].define(version: 2024_07_15_201230) do
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

  create_table "conferences", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "uuid", null: false
    t.text "bio"
    t.string "job_title"
    t.string "github_url"
    t.string "linkedin_url"
    t.string "twitter_url"
    t.boolean "mail_notifications", default: true, null: false
    t.boolean "in_app_notifications", default: true, null: false
    t.boolean "is_public", default: false, null: false
    t.string "profileable_type", null: false
    t.integer "profileable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profileable_type", "profileable_id"], name: "index_profiles_on_profileable"
    t.index ["uuid"], name: "index_profiles_on_uuid", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.integer "location_id", null: false
    t.integer "conference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_sessions_on_conference_id"
    t.index ["location_id"], name: "index_sessions_on_location_id"
  end

  create_table "sessions_speakers", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "speaker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id", "speaker_id"], name: "index_sessions_speakers_on_session_id_and_speaker_id", unique: true
    t.index ["session_id"], name: "index_sessions_speakers_on_session_id"
    t.index ["speaker_id"], name: "index_sessions_speakers_on_speaker_id"
  end

  create_table "sessions_tags", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id", "tag_id"], name: "index_sessions_tags_on_session_id_and_tag_id", unique: true
    t.index ["session_id"], name: "index_sessions_tags_on_session_id"
    t.index ["tag_id"], name: "index_sessions_tags_on_tag_id"
  end

  create_table "sessions_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_users_on_session_id"
    t.index ["user_id", "session_id"], name: "index_sessions_users_on_user_id_and_session_id", unique: true
    t.index ["user_id"], name: "index_sessions_users_on_user_id"
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
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "locations", "conferences"
  add_foreign_key "sessions", "conferences"
  add_foreign_key "sessions", "locations"
  add_foreign_key "sessions_speakers", "sessions"
  add_foreign_key "sessions_speakers", "speakers"
  add_foreign_key "sessions_tags", "sessions"
  add_foreign_key "sessions_tags", "tags"
  add_foreign_key "sessions_users", "sessions"
  add_foreign_key "sessions_users", "users"
end
