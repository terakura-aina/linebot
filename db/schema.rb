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

ActiveRecord::Schema.define(version: 2021_02_10_143714) do

  create_table "make_plans", force: :cascade do |t|
    t.integer "inviter_id", null: false
    t.integer "partner_id", null: false
    t.integer "schedule_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inviter_id"], name: "index_make_plans_on_inviter_id"
    t.index ["partner_id"], name: "index_make_plans_on_partner_id"
    t.index ["schedule_id"], name: "index_make_plans_on_schedule_id", unique: true
  end

  create_table "missions", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "start_planned_day_at", null: false
    t.datetime "finish_planned_day_at", null: false
    t.text "place"
    t.text "other"
    t.text "token", null: false
    t.integer "inviter_id"
    t.integer "answer", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inviter_id"], name: "index_schedules_on_inviter_id"
  end

  create_table "today_missions", force: :cascade do |t|
    t.integer "schedule_id", null: false
    t.integer "inviter_mission_id", null: false
    t.integer "partner_mission_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inviter_mission_id"], name: "index_today_missions_on_inviter_mission_id"
    t.index ["partner_mission_id"], name: "index_today_missions_on_partner_mission_id"
    t.index ["schedule_id"], name: "index_today_missions_on_schedule_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "line_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "make_plans", "schedules"
  add_foreign_key "make_plans", "users", column: "inviter_id"
  add_foreign_key "make_plans", "users", column: "partner_id"
  add_foreign_key "schedules", "users", column: "inviter_id"
  add_foreign_key "today_missions", "missions", column: "inviter_mission_id"
  add_foreign_key "today_missions", "missions", column: "partner_mission_id"
  add_foreign_key "today_missions", "schedules"
end
