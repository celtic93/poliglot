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

ActiveRecord::Schema.define(version: 2021_08_16_152703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adjective_forms", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.string "ru_2"
    t.string "ru_plural"
    t.string "ru_plural_2"
    t.integer "kind"
    t.bigint "adjective_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["adjective_id"], name: "index_adjective_forms_on_adjective_id"
  end

  create_table "adjectives", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.string "ru_2"
    t.string "en_plural"
    t.string "ru_plural"
    t.string "ru_plural_2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "profession", default: false
  end

  create_table "phrases", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.string "en_input"
    t.bigint "lesson_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["lesson_id"], name: "index_phrases_on_lesson_id"
    t.index ["user_id"], name: "index_phrases_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pronoun_forms", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.bigint "pronoun_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pronoun_id"], name: "index_pronoun_forms_on_pronoun_id"
  end

  create_table "pronouns", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "kind"
  end

  create_table "question_words", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_words_verbs", id: false, force: :cascade do |t|
    t.bigint "question_word_id"
    t.bigint "verb_id"
  end

  create_table "timeframes", force: :cascade do |t|
    t.string "en"
    t.string "ru"
    t.integer "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "telegram_id"
    t.bigint "lesson_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_users_on_lesson_id"
  end

  create_table "verb_pronoun_forms", force: :cascade do |t|
    t.bigint "verb_id"
    t.bigint "pronoun_id"
    t.bigint "pronoun_form_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pronoun_form_id"], name: "index_verb_pronoun_forms_on_pronoun_form_id"
    t.index ["pronoun_id"], name: "index_verb_pronoun_forms_on_pronoun_id"
    t.index ["verb_id"], name: "index_verb_pronoun_forms_on_verb_id"
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
