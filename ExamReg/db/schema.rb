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

ActiveRecord::Schema.define(version: 2019_10_31_095822) do

  create_table "course_students", force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
    t.boolean "banned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_students_on_course_id"
    t.index ["student_id"], name: "index_course_students_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "courseID", null: false
    t.string "name", null: false
    t.integer "credit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "progress_stage"
    t.integer "progress_current", default: 0
    t.integer "progress_max", default: 0
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "exam_schedules", force: :cascade do |t|
    t.integer "exam_id"
    t.integer "course_id"
    t.date "start"
    t.date "finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_exam_schedules_on_course_id"
    t.index ["exam_id"], name: "index_exam_schedules_on_exam_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "student_id"
    t.integer "exam_schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_schedule_id"], name: "index_registrations_on_exam_schedule_id"
    t.index ["student_id"], name: "index_registrations_on_student_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "roomID"
    t.integer "slot"
    t.integer "exam_schedules_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_schedules_id"], name: "index_rooms_on_exam_schedules_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "studentID", null: false
    t.string "firstName", null: false
    t.string "lastName", null: false
    t.date "birthday"
    t.boolean "sex"
    t.string "classID"
    t.string "major"
    t.string "faculty"
    t.string "password"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "role", limit: 64
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
