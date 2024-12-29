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

ActiveRecord::Schema[8.0].define(version: 2024_12_29_015452) do
  create_table "action_logs", force: :cascade do |t|
    t.string "issue_id"
    t.integer "action_type"
    t.text "action_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sla_rules", force: :cascade do |t|
    t.integer "filter_type"
    t.integer "filter_target"
    t.integer "inactive_duration"
    t.integer "action_type"
    t.text "action_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end