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

ActiveRecord::Schema.define(version: 20170922154455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_tracking_actions", force: :cascade do |t|
    t.string "author_type", null: false
    t.bigint "author_id", null: false
    t.string "actionable_type", null: false
    t.bigint "actionable_id", null: false
    t.integer "action_type", null: false
    t.integer "counter", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actionable_id", "actionable_type"], name: "index_actions_on_actionable"
    t.index ["author_id", "author_type", "actionable_id", "actionable_type"], name: "index_actions_on_author_and_actionable"
    t.index ["author_type", "author_id"], name: "index_action_tracking_actions_on_author_type_and_author_id"
  end

  create_table "action_tracking_documents", force: :cascade do |t|
    t.string "actionable_type", null: false
    t.bigint "actionable_id", null: false
    t.jsonb "counters", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actionable_id", "actionable_type"], name: "index_action_tracking_documents_on_actionable", unique: true
    t.index ["counters"], name: "index_action_tracking_documents_on_counters", using: :gin
  end

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
