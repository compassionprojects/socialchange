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

ActiveRecord::Schema[7.1].define(version: 2024_02_01_113721) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

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

  create_table "categories", force: :cascade do |t|
    t.jsonb "name", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contributions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "story_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_contributions_on_story_id"
    t.index ["user_id", "story_id"], name: "index_contributions_on_user_id_and_story_id", unique: true
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.bigint "story_id", null: false
    t.bigint "user_id", null: false
    t.bigint "updater_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_discussions_on_discarded_at"
    t.index ["story_id"], name: "index_discussions_on_story_id"
    t.index ["updater_id"], name: "index_discussions_on_updater_id"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_permissions_on_name", unique: true
  end

  create_table "permissions_roles", primary_key: ["role_id", "permission_id"], force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id"
    t.index ["role_id", "permission_id"], name: "index_permissions_roles_on_role_id_and_permission_id", unique: true
    t.index ["role_id"], name: "index_permissions_roles_on_role_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "updater_id", null: false
    t.bigint "discussion_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_posts_on_discarded_at"
    t.index ["discussion_id"], name: "index_posts_on_discussion_id"
    t.index ["updater_id"], name: "index_posts_on_updater_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "notify_new_discussion_on_story", default: true, null: false
    t.boolean "notify_new_post_on_discussion", default: true, null: false
    t.boolean "notify_any_post_in_discussion", default: true, null: false
    t.boolean "notify_new_story", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "roles_users", primary_key: ["user_id", "role_id"], force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.jsonb "description", default: {}, null: false
    t.jsonb "outcomes", default: {}
    t.jsonb "source", default: {}
    t.string "country"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id", null: false
    t.bigint "updater_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.bigint "category_id"
    t.index "((title ->> 'en'::text)) gin_trgm_ops, ((description ->> 'en'::text)) gin_trgm_ops, ((outcomes ->> 'en'::text)) gin_trgm_ops, ((source ->> 'en'::text)) gin_trgm_ops", name: "index_stories_on_title_desc_out_src_en", using: :gin
    t.index "((title ->> 'nl'::text)) gin_trgm_ops, ((description ->> 'nl'::text)) gin_trgm_ops, ((outcomes ->> 'nl'::text)) gin_trgm_ops, ((source ->> 'nl'::text)) gin_trgm_ops", name: "index_stories_on_title_desc_out_src_nl", using: :gin
    t.index ["category_id"], name: "index_stories_on_category_id"
    t.index ["discarded_at"], name: "index_stories_on_discarded_at"
    t.index ["updater_id"], name: "index_stories_on_updater_id"
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "story_updates", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.jsonb "description", default: {}, null: false
    t.bigint "story_id", null: false
    t.bigint "user_id", null: false
    t.bigint "updater_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "((title ->> 'en'::text)) gin_trgm_ops, ((description ->> 'en'::text)) gin_trgm_ops", name: "index_story_updates_on_title_desc_en", using: :gin
    t.index "((title ->> 'nl'::text)) gin_trgm_ops, ((description ->> 'nl'::text)) gin_trgm_ops", name: "index_story_updates_on_title_desc_nl", using: :gin
    t.index ["discarded_at"], name: "index_story_updates_on_discarded_at"
    t.index ["story_id"], name: "index_story_updates_on_story_id"
    t.index ["updater_id"], name: "index_story_updates_on_updater_id"
    t.index ["user_id"], name: "index_story_updates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: ""
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "language"
    t.datetime "discarded_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contributions", "stories"
  add_foreign_key "contributions", "users"
  add_foreign_key "discussions", "stories"
  add_foreign_key "discussions", "users"
  add_foreign_key "discussions", "users", column: "updater_id"
  add_foreign_key "posts", "discussions"
  add_foreign_key "posts", "users"
  add_foreign_key "posts", "users", column: "updater_id"
  add_foreign_key "preferences", "users"
  add_foreign_key "stories", "categories"
  add_foreign_key "stories", "users"
  add_foreign_key "stories", "users", column: "updater_id"
  add_foreign_key "story_updates", "stories"
  add_foreign_key "story_updates", "users"
  add_foreign_key "story_updates", "users", column: "updater_id"
end
