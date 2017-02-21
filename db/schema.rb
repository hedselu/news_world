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

ActiveRecord::Schema.define(version: 20160508201454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "categories_users", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string   "description"
    t.string   "title"
    t.string   "source"
    t.string   "text"
    t.string   "image_url"
    t.string   "publish_date"
    t.integer  "up_votes",     default: 0
    t.integer  "down_votes",   default: 0
    t.integer  "category_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",                            null: false
    t.string   "email",                            null: false
    t.string   "password_digest",                  null: false
    t.boolean  "categories_set",  default: false
    t.string   "role",            default: "user"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "news_id"
    t.integer  "user_id"
    t.boolean  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
