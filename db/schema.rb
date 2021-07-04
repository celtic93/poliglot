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

ActiveRecord::Schema.define(version: 2021_07_01_174824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "phrases", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.string "en_input"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pronouns", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "verbs", force: :cascade do |t|
    t.string "en"
    t.string "en_with_s"
    t.string "en_form_2"
    t.string "ru"
    t.string "ru_present_i"
    t.string "ru_present_you"
    t.string "ru_present_he"
    t.string "ru_present_she"
    t.string "ru_present_we"
    t.string "ru_present_they"
    t.string "ru_past_i"
    t.string "ru_past_you"
    t.string "ru_past_he"
    t.string "ru_past_she"
    t.string "ru_past_we"
    t.string "ru_past_they"
    t.string "ru_future_i"
    t.string "ru_future_you"
    t.string "ru_future_he"
    t.string "ru_future_she"
    t.string "ru_future_we"
    t.string "ru_future_they"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end