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

ActiveRecord::Schema.define(version: 20180417021220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "phone_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "sponsor", default: false
    t.boolean "vote", default: true
  end

  create_table "pendings", force: :cascade do |t|
    t.bigint "participant_id"
    t.bigint "proposal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.index ["participant_id"], name: "index_pendings_on_participant_id"
    t.index ["proposal_id"], name: "index_pendings_on_proposal_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "tech"
    t.integer "theme"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "documentation_file_name"
    t.string "documentation_content_type"
    t.integer "documentation_file_size"
    t.datetime "documentation_updated_at"
  end

  create_table "proposals", force: :cascade do |t|
    t.string "title", limit: 65, null: false
    t.string "description", limit: 255, null: false
    t.boolean "status", default: true
    t.bigint "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "theme", default: 1
    t.string "tech", limit: 30
    t.boolean "top5", default: false
    t.string "documentation_file_name"
    t.string "documentation_content_type"
    t.integer "documentation_file_size"
    t.datetime "documentation_updated_at"
    t.integer "sp_marks", default: 0
    t.index ["participant_id"], name: "index_proposals_on_participant_id"
  end

  create_table "sponsor_votes", force: :cascade do |t|
    t.integer "first_place"
    t.integer "second_place"
    t.integer "third_place"
    t.integer "fourth_place"
    t.integer "fifth_place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sponsor_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_members", force: :cascade do |t|
    t.bigint "proposal_id"
    t.bigint "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "active"
    t.index ["participant_id"], name: "index_team_members_on_participant_id"
    t.index ["proposal_id"], name: "index_team_members_on_proposal_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "participant_id"
    t.bigint "proposal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_votes_on_participant_id"
    t.index ["proposal_id"], name: "index_votes_on_proposal_id"
  end

  add_foreign_key "pendings", "participants"
  add_foreign_key "pendings", "proposals"
  add_foreign_key "proposals", "participants"
  add_foreign_key "team_members", "participants"
  add_foreign_key "team_members", "proposals"
  add_foreign_key "votes", "participants"
  add_foreign_key "votes", "proposals"
end
