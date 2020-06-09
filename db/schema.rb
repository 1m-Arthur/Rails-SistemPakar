# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_06_043255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diseases", force: :cascade do |t|
    t.string "code_penyakit"
    t.string "nama_penyakit"
  end

  create_table "event_logs", force: :cascade do |t|
    t.string "signature"
    t.text "events"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "kesimpulans", force: :cascade do |t|
    t.string "stage"
    t.string "code_penyakit"
    t.string "mulai"
    t.string "selesai"
  end

  create_table "questions", force: :cascade do |t|
    t.string "stage"
    t.string "nama_gejala"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id"
    t.string "display_name"
    t.string "line_id"
    t.string "hasil"
    t.string "number_stage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
