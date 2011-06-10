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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110610213925) do

  create_table "authors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "initials"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors_papers", :id => false, :force => true do |t|
    t.integer "author_id"
    t.integer "paper_id"
  end

  create_table "comps", :force => true do |t|
    t.string   "comp_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiments", :force => true do |t|
    t.integer  "exp_type"
    t.string   "title"
    t.text     "task_desc"
    t.text     "interface_desc"
    t.integer  "env_dim"
    t.integer  "env_scale"
    t.integer  "env_density"
    t.integer  "env_realism"
    t.text     "env_desc"
    t.integer  "part_num"
    t.integer  "part_gender"
    t.integer  "part_age"
    t.text     "part_background"
    t.text     "part_other"
    t.text     "systems_tech"
    t.text     "systems_desc"
    t.text     "comps_desc"
    t.text     "variables_desc"
    t.text     "constants"
    t.text     "other"
    t.integer  "num_views"
    t.integer  "status"
    t.integer  "paper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiments_comps", :id => false, :force => true do |t|
    t.integer "experiment_id"
    t.integer "comp_id"
  end

  create_table "experiments_metrics", :id => false, :force => true do |t|
    t.integer "experiment_id"
    t.integer "metric_id"
  end

  create_table "experiments_systems", :id => false, :force => true do |t|
    t.integer "experiment_id"
    t.integer "system_id"
  end

  create_table "experiments_tasks", :id => false, :force => true do |t|
    t.integer "experiment_id"
    t.integer "task_id"
  end

  create_table "findings", :force => true do |t|
    t.text     "finding"
    t.integer  "specificity"
    t.text     "issues"
    t.integer  "num_views"
    t.string   "status"
    t.integer  "experiment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "findings_comps", :id => false, :force => true do |t|
    t.integer "finding_id"
    t.integer "comp_id"
  end

  create_table "findings_metrics", :id => false, :force => true do |t|
    t.integer "finding_id"
    t.integer "metric_id"
  end

  create_table "findings_systems", :id => false, :force => true do |t|
    t.integer "finding_id"
    t.integer "system_id"
  end

  create_table "findings_tasks", :id => false, :force => true do |t|
    t.integer "finding_id"
    t.integer "task_id"
  end

  create_table "metrics", :force => true do |t|
    t.string   "metric_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "papers", :force => true do |t|
    t.string   "title"
    t.string   "journal"
    t.date     "year"
    t.integer  "volume"
    t.integer  "number"
    t.integer  "first_page"
    t.integer  "last_page"
    t.string   "doi"
    t.string   "paper_url"
    t.integer  "num_views"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "systems", :force => true do |t|
    t.string   "system_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "task_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
