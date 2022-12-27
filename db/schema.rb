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

ActiveRecord::Schema[7.0].define(version: 2022_12_27_121207) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

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
    t.integer "status"
    t.string "country"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id", null: false
    t.bigint "updater_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index "((title ->> 'en'::text)) gin_trgm_ops, ((description ->> 'en'::text)) gin_trgm_ops, ((outcomes ->> 'en'::text)) gin_trgm_ops, ((source ->> 'en'::text)) gin_trgm_ops", name: "index_stories_on_title_desc_out_src_en", using: :gin
    t.index "((title ->> 'nl'::text)) gin_trgm_ops, ((description ->> 'nl'::text)) gin_trgm_ops, ((outcomes ->> 'nl'::text)) gin_trgm_ops, ((source ->> 'nl'::text)) gin_trgm_ops", name: "index_stories_on_title_desc_out_src_nl", using: :gin
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

  add_foreign_key "stories", "users"
  add_foreign_key "stories", "users", column: "updater_id"
  add_foreign_key "story_updates", "stories"
  add_foreign_key "story_updates", "users"
  add_foreign_key "story_updates", "users", column: "updater_id"
end
