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

ActiveRecord::Schema.define(version: 2022_06_22_221233) do

  create_table "cad_systems", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "from_id", null: false
    t.integer "to_id", null: false
    t.text "input_text"
    t.text "result"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["from_id"], name: "index_sessions_on_from_id"
    t.index ["to_id"], name: "index_sessions_on_to_id"
  end

  create_table "vocabularies", force: :cascade do |t|
    t.integer "cad_system_id", null: false
    t.json "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cad_system_id"], name: "index_vocabularies_on_cad_system_id"
  end

  add_foreign_key "sessions", "cad_systems", column: "from_id"
  add_foreign_key "sessions", "cad_systems", column: "to_id"
  add_foreign_key "vocabularies", "cad_systems"
end
