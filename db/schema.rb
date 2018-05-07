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

ActiveRecord::Schema.define(version: 20180417155102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analysis_results", force: :cascade do |t|
    t.bigint "analytical_item_id"
    t.bigint "medical_test_id"
    t.float "amount"
    t.string "unit"
    t.string "level"
    t.string "grade"
    t.text "interpretation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analytical_item_id"], name: "index_analysis_results_on_analytical_item_id"
    t.index ["medical_test_id"], name: "index_analysis_results_on_medical_test_id"
  end

  create_table "analytical_groups", force: :cascade do |t|
    t.string "name"
    t.boolean "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "analytical_items", force: :cascade do |t|
    t.string "name"
    t.bigint "analytical_group_id"
    t.bigint "analytical_subgroup_id"
    t.string "unit"
    t.string "max_range"
    t.string "min_range"
    t.boolean "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analytical_group_id"], name: "index_analytical_items_on_analytical_group_id"
    t.index ["analytical_subgroup_id"], name: "index_analytical_items_on_analytical_subgroup_id"
  end

  create_table "analytical_subgroups", force: :cascade do |t|
    t.string "name"
    t.bigint "analytical_group_id"
    t.boolean "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analytical_group_id"], name: "index_analytical_subgroups_on_analytical_group_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.bigint "user_id"
    t.string "documentable_type"
    t.bigint "documentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["documentable_type", "documentable_id"], name: "index_documents_on_documentable_type_and_documentable_id"
    t.index ["user_id", "documentable_type", "documentable_id"], name: "access_documents"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.datetime "event_at"
    t.string "kind"
    t.bigint "user_id"
    t.bigint "professional_id"
    t.bigint "medical_center_id"
    t.text "reason"
    t.string "location"
    t.text "note"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_center_id"], name: "index_histories_on_medical_center_id"
    t.index ["professional_id"], name: "index_histories_on_professional_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "medical_centers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "kind"
    t.string "main_phone"
    t.string "phone"
    t.string "email"
    t.string "web"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medical_tests", force: :cascade do |t|
    t.bigint "history_id"
    t.string "name"
    t.bigint "medical_center_id"
    t.text "instructions"
    t.text "report"
    t.datetime "performed_at"
    t.string "performed_in"
    t.index ["history_id"], name: "index_medical_tests_on_history_id"
    t.index ["medical_center_id"], name: "index_medical_tests_on_medical_center_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.string "active_ingredient"
    t.string "presentation"
    t.string "laboratory"
    t.string "prospect_file_name"
    t.string "prospect_content_type"
    t.integer "prospect_file_size"
    t.datetime "prospect_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "name_tests", force: :cascade do |t|
    t.string "name"
    t.string "code"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.bigint "history_id"
    t.bigint "medication_id"
    t.string "posology"
    t.date "init_at"
    t.date "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["history_id"], name: "index_prescriptions_on_history_id"
    t.index ["medication_id"], name: "index_prescriptions_on_medication_id"
    t.index ["posology"], name: "index_prescriptions_on_posology"
  end

  create_table "professionals", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "speciality_id"
    t.bigint "medical_center_id"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_center_id"], name: "index_professionals_on_medical_center_id"
    t.index ["speciality_id"], name: "index_professionals_on_speciality_id"
  end

  create_table "specialities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "born_date"
    t.string "document"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "public_health_org"
    t.string "public_health_org_url"
    t.string "public_health_membership_number"
    t.string "public_health_autonomic_code"
    t.string "public_health_card_number"
    t.string "private_health_company"
    t.string "private_health_company_url"
    t.string "private_health_card_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "analysis_results", "analytical_items"
  add_foreign_key "analysis_results", "medical_tests"
  add_foreign_key "analytical_items", "analytical_groups"
  add_foreign_key "analytical_items", "analytical_subgroups"
  add_foreign_key "documents", "users"
  add_foreign_key "histories", "medical_centers"
  add_foreign_key "histories", "professionals"
  add_foreign_key "histories", "users"
  add_foreign_key "prescriptions", "histories"
  add_foreign_key "prescriptions", "medications"
end
