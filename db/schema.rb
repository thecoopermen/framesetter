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

ActiveRecord::Schema.define(version: 20150222233831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comps", force: :cascade do |t|
    t.string   "name"
    t.boolean  "portrait"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "frames", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "frameset_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "top"
    t.integer  "left"
    t.integer  "width"
    t.integer  "height"
    t.integer  "original_0_top"
    t.integer  "original_0_left"
    t.integer  "original_0_width"
    t.integer  "original_0_height"
    t.integer  "original_90_top"
    t.integer  "original_90_left"
    t.integer  "original_90_width"
    t.integer  "original_90_height"
    t.integer  "original_180_top"
    t.integer  "original_180_left"
    t.integer  "original_180_width"
    t.integer  "original_180_height"
    t.integer  "original_270_top"
    t.integer  "original_270_left"
    t.integer  "original_270_width"
    t.integer  "original_270_height"
    t.integer  "preview_0_top"
    t.integer  "preview_0_left"
    t.integer  "preview_0_width"
    t.integer  "preview_0_height"
    t.integer  "preview_90_top"
    t.integer  "preview_90_left"
    t.integer  "preview_90_width"
    t.integer  "preview_90_height"
    t.integer  "preview_180_top"
    t.integer  "preview_180_left"
    t.integer  "preview_180_width"
    t.integer  "preview_180_height"
    t.integer  "preview_270_top"
    t.integer  "preview_270_left"
    t.integer  "preview_270_width"
    t.integer  "preview_270_height"
  end

  create_table "framesets", force: :cascade do |t|
    t.string   "name"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
