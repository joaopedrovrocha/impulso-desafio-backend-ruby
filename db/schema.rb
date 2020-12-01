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

ActiveRecord::Schema.define(version: 2020_12_01_164914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cnab_upload_contents", force: :cascade do |t|
    t.bigint "cnab_upload_id"
    t.text "row_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cnab_upload_id"], name: "index_cnab_upload_contents_on_cnab_upload_id"
  end

  create_table "cnab_uploads", force: :cascade do |t|
    t.string "filename"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "transaction_type"
    t.date "transaction_date"
    t.decimal "value"
    t.string "tax_number"
    t.string "card"
    t.time "transaction_time"
    t.string "responsible_name"
    t.string "store"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "cnab_upload_id"
    t.index ["cnab_upload_id"], name: "index_transactions_on_cnab_upload_id"
  end

end
