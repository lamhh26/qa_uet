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

ActiveRecord::Schema.define(version: 20180320124119) do

  create_table "actions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "step_id"
    t.string "value"
    t.integer "status"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_actions_on_parent_id"
    t.index ["step_id"], name: "index_actions_on_step_id"
  end

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "ahoy_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "visit_id"
    t.integer "user_id"
    t.string "user_type"
    t.string "name"
    t.text "properties"
    t.timestamp "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["user_id", "user_type", "name"], name: "index_ahoy_events_on_user_id_and_user_type_and_name"
    t.index ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name"
  end

  create_table "allowances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "key"
    t.float "value", limit: 24
    t.integer "kind"
    t.integer "kind_value"
    t.integer "company_id"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_allowances_on_company_id"
    t.index ["parent_id"], name: "index_allowances_on_parent_id"
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "post_id"
    t.bigint "user_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_features", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "company_id"
    t.bigint "feature_id"
    t.boolean "enabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_features_on_company_id"
    t.index ["feature_id"], name: "index_company_features_on_feature_id"
  end

  create_table "company_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "company_id"
    t.integer "currency", default: 151
    t.integer "pay_day"
    t.integer "norm_working_day"
    t.float "max_overtime_per_month", limit: 24
    t.float "max_overtime_per_year", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wizard_id"
    t.index ["company_id"], name: "index_company_settings_on_company_id"
    t.index ["wizard_id"], name: "index_company_settings_on_wizard_id"
  end

  create_table "comparison_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "comparison_id"
    t.bigint "salary_module_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comparison_id"], name: "index_comparison_items_on_comparison_id"
    t.index ["salary_module_id"], name: "index_comparison_items_on_salary_module_id"
  end

  create_table "comparisons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "company_id"
    t.string "title"
    t.string "employee_code"
    t.string "value_column"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_comparisons_on_company_id"
  end

  create_table "contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["company_id"], name: "index_contracts_on_company_id"
  end

  create_table "employee_allowances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal "value", precision: 10
    t.bigint "employee_id"
    t.bigint "month_year_id"
    t.bigint "allowance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["allowance_id"], name: "index_employee_allowances_on_allowance_id"
    t.index ["employee_id", "allowance_id", "month_year_id"], name: "employee_allowances_unique", unique: true
    t.index ["employee_id"], name: "index_employee_allowances_on_employee_id"
    t.index ["month_year_id"], name: "index_employee_allowances_on_month_year_id"
  end

  create_table "employee_exceptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "employee_id"
    t.bigint "month_year_id"
    t.bigint "salary_module_id"
    t.integer "kind"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_employee_exceptions_on_company_id"
    t.index ["employee_id"], name: "index_employee_exceptions_on_employee_id"
    t.index ["month_year_id"], name: "index_employee_exceptions_on_month_year_id"
    t.index ["salary_module_id"], name: "index_employee_exceptions_on_salary_module_id"
  end

  create_table "employee_information_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "key"
    t.bigint "company_id"
    t.integer "kind"
    t.integer "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employee_information_settings_on_company_id"
  end

  create_table "employee_informations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "employee_id"
    t.bigint "month_year_id"
    t.bigint "employee_information_setting_id"
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_informations_on_employee_id"
    t.index ["employee_information_setting_id"], name: "index_employee_informations_on_employee_information_setting_id"
    t.index ["month_year_id"], name: "index_employee_informations_on_month_year_id"
  end

  create_table "employee_overtimes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "kind"
    t.string "real_value"
    t.string "value"
    t.float "last_month_over", limit: 24
    t.bigint "employee_id"
    t.bigint "overtime_id"
    t.bigint "month_year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id", "overtime_id", "month_year_id"], name: "add_unique_employee_overtime", unique: true
    t.index ["employee_id"], name: "index_employee_overtimes_on_employee_id"
    t.index ["month_year_id"], name: "index_employee_overtimes_on_month_year_id"
    t.index ["overtime_id"], name: "index_employee_overtimes_on_overtime_id"
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.bigint "company_id"
    t.bigint "contract_id"
    t.string "employee_code", default: "", null: false
    t.string "name"
    t.string "avatar"
    t.integer "sex"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_otp_secret"
    t.string "encrypted_otp_secret_iv"
    t.string "encrypted_otp_secret_salt"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login"
    t.text "base_64_code"
    t.text "otp_backup_codes"
    t.integer "locale", default: 0
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["contract_id"], name: "index_employees_on_contract_id"
    t.index ["employee_code", "company_id"], name: "index_employees_on_employee_code_and_company_id", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "exception_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content"
    t.text "file_name"
    t.bigint "company_id"
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_exception_logs_on_company_id"
    t.index ["manager_id"], name: "index_exception_logs_on_manager_id"
  end

  create_table "features", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "feature_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_landings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "image"
    t.boolean "public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "landing_page_id"
    t.index ["landing_page_id"], name: "index_image_landings_on_landing_page_id"
  end

  create_table "import_setting_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "import_config"
    t.string "import_column_key"
    t.bigint "import_setting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["import_setting_id"], name: "index_import_setting_items_on_import_setting_id"
  end

  create_table "import_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "column_key"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_import_settings_on_company_id"
  end

  create_table "landing_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "logo"
    t.string "background"
    t.string "slogan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "management_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "manager_id"
    t.string "management_config"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_management_items_on_manager_id"
  end

  create_table "manager_notices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "manager_id"
    t.bigint "month_year_id"
    t.text "notice_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_manager_notices_on_manager_id"
    t.index ["month_year_id"], name: "index_manager_notices_on_month_year_id"
  end

  create_table "manager_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "month_year_id"
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_manager_settings_on_manager_id"
    t.index ["month_year_id"], name: "index_manager_settings_on_month_year_id"
  end

  create_table "managers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.integer "role", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.text "base_64_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.bigint "manager_setting_id"
    t.string "encrypted_otp_secret"
    t.string "encrypted_otp_secret_iv"
    t.string "encrypted_otp_secret_salt"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login", default: false
    t.text "otp_backup_codes"
    t.integer "locale", default: 0
    t.index ["company_id"], name: "index_managers_on_company_id"
    t.index ["email", "company_id"], name: "index_managers_on_email_and_company_id", unique: true
    t.index ["manager_setting_id"], name: "index_managers_on_manager_setting_id"
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
  end

  create_table "month_year_salary_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "month_year_id"
    t.bigint "salary_setting_id"
    t.bigint "contract_id"
    t.integer "status", default: 0
    t.integer "color", default: 0
    t.string "sidekiq_job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_month_year_salary_settings_on_contract_id"
    t.index ["month_year_id"], name: "index_month_year_salary_settings_on_month_year_id"
    t.index ["salary_setting_id"], name: "index_month_year_salary_settings_on_salary_setting_id"
  end

  create_table "month_years", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.integer "max_working_day"
    t.boolean "is_locked", default: false
    t.string "password_digest", default: ""
    t.boolean "is_calculated", default: false
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lock_type"
    t.index ["company_id"], name: "index_month_years_on_company_id"
  end

  create_table "overtimes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.float "value", limit: 24
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_overtimes_on_company_id"
  end

  create_table "post_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "post_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_tags_on_post_id"
    t.index ["tag_id"], name: "index_post_tags_on_tag_id"
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "post_type", default: 0
    t.string "title"
    t.text "body"
    t.bigint "parent_id"
    t.bigint "owner_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answers_count", default: 0, null: false
    t.index ["owner_user_id"], name: "index_posts_on_owner_user_id"
    t.index ["parent_id"], name: "index_posts_on_parent_id"
  end

  create_table "salaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "month_year_id"
    t.bigint "employee_id"
    t.bigint "contract_id"
    t.integer "salary_setting_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_salaries_on_contract_id"
    t.index ["employee_id", "month_year_id"], name: "employee_salary_unique", unique: true
    t.index ["employee_id"], name: "index_salaries_on_employee_id"
    t.index ["month_year_id"], name: "index_salaries_on_month_year_id"
    t.index ["salary_setting_id"], name: "index_salaries_on_salary_setting_id"
  end

  create_table "salary_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "value"
    t.string "value_string"
    t.boolean "custom", default: false
    t.bigint "salary_id"
    t.bigint "salary_module_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["salary_id"], name: "index_salary_items_on_salary_id"
    t.index ["salary_module_id"], name: "index_salary_items_on_salary_module_id"
  end

  create_table "salary_module_hierarchies", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "salary_module_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "salary_module_desc_idx"
  end

  create_table "salary_modules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.text "excel_formular"
    t.string "column_key"
    t.integer "kind"
    t.text "value"
    t.string "value_association"
    t.boolean "is_value_number", default: true
    t.boolean "is_net_salary", default: false
    t.boolean "is_money", default: true
    t.boolean "allow_edit", default: true
    t.bigint "salary_setting_id"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_salary_modules_on_ancestry"
    t.index ["parent_id"], name: "index_salary_modules_on_parent_id"
    t.index ["salary_setting_id"], name: "index_salary_modules_on_salary_setting_id"
  end

  create_table "salary_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "column_key"
    t.bigint "contract_id"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "export_template"
    t.integer "start_index"
    t.index ["company_id"], name: "index_salary_settings_on_company_id"
    t.index ["contract_id"], name: "index_salary_settings_on_contract_id"
  end

  create_table "statistics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.integer "statistic_type"
    t.integer "chart_type"
    t.string "data_config"
    t.integer "width"
    t.bigint "manager_id"
    t.integer "group_id"
    t.text "selected_condition_data_values"
    t.text "selected_month_year_ids"
    t.text "selected_contract_ids"
    t.index ["group_id"], name: "index_statistics_on_group_id"
    t.index ["manager_id"], name: "index_statistics_on_manager_id"
  end

  create_table "steps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "wizard_id"
    t.string "title"
    t.integer "position"
    t.integer "status"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_steps_on_parent_id"
    t.index ["wizard_id"], name: "index_steps_on_wizard_id"
  end

  create_table "synchronize_timesheets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "month_year_id"
    t.bigint "company_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_synchronize_timesheets_on_company_id"
    t.index ["month_year_id"], name: "index_synchronize_timesheets_on_month_year_id"
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.text "about_me"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.text "landing_page"
    t.integer "user_id"
    t.string "user_type"
    t.string "referring_domain"
    t.string "search_keyword"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.integer "screen_height"
    t.integer "screen_width"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "postal_code"
    t.decimal "latitude", precision: 10
    t.decimal "longitude", precision: 10
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.timestamp "started_at"
    t.index ["user_id", "user_type"], name: "index_visits_on_user_id_and_user_type"
    t.index ["visit_token"], name: "index_visits_on_visit_token", unique: true
  end

  create_table "votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.integer "vote_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_votes_on_post_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  create_table "wizards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "company_id"
    t.string "title"
    t.bigint "creator_id"
    t.bigint "current_step_id"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_wizards_on_company_id"
    t.index ["creator_id"], name: "index_wizards_on_creator_id"
    t.index ["current_step_id"], name: "index_wizards_on_current_step_id"
    t.index ["parent_id"], name: "index_wizards_on_parent_id"
  end

  add_foreign_key "actions", "steps"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "company_features", "companies"
  add_foreign_key "company_features", "features"
  add_foreign_key "company_settings", "companies"
  add_foreign_key "company_settings", "wizards"
  add_foreign_key "comparison_items", "comparisons"
  add_foreign_key "comparison_items", "salary_modules"
  add_foreign_key "comparisons", "companies"
  add_foreign_key "employee_allowances", "allowances"
  add_foreign_key "employee_allowances", "employees"
  add_foreign_key "employee_allowances", "month_years"
  add_foreign_key "employee_exceptions", "companies"
  add_foreign_key "employee_exceptions", "employees"
  add_foreign_key "employee_exceptions", "month_years"
  add_foreign_key "employee_exceptions", "salary_modules"
  add_foreign_key "employee_information_settings", "companies"
  add_foreign_key "employee_informations", "employee_information_settings"
  add_foreign_key "employee_informations", "employees"
  add_foreign_key "employee_informations", "month_years"
  add_foreign_key "employee_overtimes", "employees"
  add_foreign_key "employee_overtimes", "month_years"
  add_foreign_key "employee_overtimes", "overtimes"
  add_foreign_key "exception_logs", "companies"
  add_foreign_key "exception_logs", "managers"
  add_foreign_key "image_landings", "landing_pages"
  add_foreign_key "import_setting_items", "import_settings"
  add_foreign_key "import_settings", "companies"
  add_foreign_key "management_items", "managers"
  add_foreign_key "manager_notices", "managers"
  add_foreign_key "manager_notices", "month_years"
  add_foreign_key "manager_settings", "managers"
  add_foreign_key "month_year_salary_settings", "contracts"
  add_foreign_key "month_year_salary_settings", "month_years"
  add_foreign_key "month_year_salary_settings", "salary_settings"
  add_foreign_key "post_tags", "posts"
  add_foreign_key "post_tags", "tags"
  add_foreign_key "posts", "users", column: "owner_user_id"
  add_foreign_key "salaries", "contracts"
  add_foreign_key "salaries", "employees"
  add_foreign_key "salaries", "month_years"
  add_foreign_key "salary_items", "salaries"
  add_foreign_key "salary_items", "salary_modules"
  add_foreign_key "salary_modules", "salary_settings"
  add_foreign_key "statistics", "managers"
  add_foreign_key "steps", "wizards"
  add_foreign_key "synchronize_timesheets", "companies"
  add_foreign_key "synchronize_timesheets", "month_years"
  add_foreign_key "votes", "posts"
  add_foreign_key "wizards", "companies"
end
