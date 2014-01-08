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

ActiveRecord::Schema.define(version: 20140107104239) do

  create_table "channels", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "channel_name"
    t.string   "classification", default: "0"
    t.string   "ownership",      default: "0"
  end

  add_index "channels", ["channel_name"], name: "index_channels_on_channel_name", using: :btree

  create_table "date_ranges", force: true do |t|
    t.string   "date_range"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "date_ranges", ["date_range"], name: "index_date_ranges_on_date_range", using: :btree

  create_table "date_ranges_uploads", id: false, force: true do |t|
    t.integer "date_range_id"
    t.integer "upload_id"
  end

  add_index "date_ranges_uploads", ["date_range_id"], name: "index_date_ranges_uploads_on_date_range_id", using: :btree
  add_index "date_ranges_uploads", ["upload_id"], name: "index_date_ranges_uploads_on_upload_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "demos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_slot_id"
    t.string   "metric_type"
    t.string   "Ind.2+"
    t.string   "A18+"
    t.string   "A25-54"
    t.string   "A18-49"
    t.string   "A18-34"
    t.string   "A55+"
    t.string   "F25-54"
    t.string   "F18-49"
    t.string   "F18-34"
    t.string   "M25-54"
    t.string   "M18-49"
    t.string   "M18-34"
    t.string   "A12-34"
    t.string   "T12-17"
    t.string   "C2-11"
  end

  add_index "demos", ["program_slot_id", "metric_type"], name: "index_demos_on_program_slot_id_and_metric_type", using: :btree

  create_table "markets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "market_name"
  end

  create_table "program_slots", force: true do |t|
    t.integer  "program_id"
    t.integer  "market_id"
    t.integer  "channel_id"
    t.string   "infosys_start"
    t.string   "infosys_end"
    t.string   "infosys_airdate"
    t.string   "infosys_day"
    t.datetime "calendar_start"
    t.datetime "calendar_end"
    t.date     "calendar_airdate"
    t.string   "timeslot"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "normalized_start_time"
    t.string   "normalized_date"
    t.string   "normalized_end_time"
  end

  add_index "program_slots", ["market_id", "channel_id"], name: "index_program_slots_on_market_id_and_channel_id", using: :btree

  create_table "programs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "program_name"
    t.string   "episode_name"
  end

  add_index "programs", ["program_name", "episode_name"], name: "index_programs_on_program_name_and_episode_name", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sourcedata_file_name"
    t.string   "sourcedata_content_type"
    t.integer  "sourcedata_file_size"
    t.datetime "sourcedata_updated_at"
    t.integer  "task_id"
    t.integer  "status",                  default: 0, null: false
    t.string   "f_path"
    t.string   "job"
    t.string   "daterange"
    t.string   "email"
    t.integer  "total_rows"
    t.integer  "rows_completed"
  end

  create_table "visualizations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.string   "code"
  end

end
