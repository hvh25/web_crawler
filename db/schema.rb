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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130403044607) do

  create_table "assignments", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "user_id"
    t.string   "role_id"
  end

  create_table "base_urls", :force => true do |t|
    t.string   "page_url"
    t.string   "common_url"
    t.string   "base"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "sourcetype"
    t.string   "jobrowcss"
    t.string   "companycss"
    t.string   "locationcss"
    t.string   "descriptioncss"
    t.string   "requirementcss"
    t.string   "availabilitycss"
    t.string   "jobtypecss"
    t.string   "titlecss"
    t.string   "company0"
    t.string   "location0"
    t.string   "description0"
    t.string   "requirement0"
    t.string   "jobtype0"
    t.integer  "avail0"
    t.string   "comptype"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "jobapps", :force => true do |t|
    t.text     "education"
    t.text     "experience"
    t.integer  "job_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "user_id"
    t.text     "skill"
    t.text     "other"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
  end

  add_index "jobapps", ["job_id"], :name => "index_jobapps_on_job_id"

  create_table "jobs", :force => true do |t|
    t.string   "url"
    t.text     "description",  :limit => 255
    t.string   "company"
    t.date     "availability"
    t.string   "title"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "word_id"
    t.string   "location"
    t.text     "requirement"
    t.string   "jobtype"
    t.integer  "user_id"
    t.integer  "base_url_id"
    t.string   "comptype"
    t.string   "slug"
    t.integer  "source_id"
    t.string   "source_type"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "firstname"
    t.string   "lastname"
    t.text     "education"
    t.text     "experience"
    t.text     "skill"
    t.string   "resume"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "words", :force => true do |t|
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "job_id"
  end

end
