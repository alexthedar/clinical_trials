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

ActiveRecord::Schema.define(version: 20150519212518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "gender"
    t.date   "birthday"
  end

  create_table "schedules", force: :cascade do |t|
    t.string  "description"
    t.integer "visit_number"
    t.integer "days_to_next"
    t.integer "trial_id"
  end

  add_index "schedules", ["trial_id"], name: "index_schedules_on_trial_id", using: :btree

  create_table "specialists", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
  end

  create_table "trials", force: :cascade do |t|
    t.string  "company"
    t.string  "name"
    t.integer "number_of_visits"
    t.string  "description"
  end

  create_table "vacations", force: :cascade do |t|
    t.date    "date"
    t.integer "number_of_days"
    t.integer "specialist_id"
  end

  add_index "vacations", ["specialist_id"], name: "index_vacations_on_specialist_id", using: :btree

  create_table "visits", force: :cascade do |t|
    t.integer "trial_id"
    t.integer "patient_id"
    t.integer "specialist_id"
    t.boolean "appt_attended"
    t.integer "schedule_id"
    t.boolean "initial_appt_date"
    t.date    "appt_date"
  end

end
