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

ActiveRecord::Schema.define(:version => 20130527210757) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "profile_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "active"
    t.string   "permission"
  end

  create_table "memories", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "profile_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "memories", ["profile_id", "created_at"], :name => "index_memories_on_profile_id_and_created_at"
  add_index "memories", ["user_id", "created_at"], :name => "index_memories_on_user_id_and_created_at"
  add_index "memories", ["user_id", "profile_id", "created_at"], :name => "index_memories_on_user_id_and_profile_id_and_created_at"

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.date     "deathday"
    t.integer  "privacy"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
    t.string   "url"
  end

  add_index "profiles", ["slug"], :name => "index_profiles_on_slug", :unique => true
  add_index "profiles", ["url"], :name => "index_profiles_on_url", :unique => true

  create_table "relationshipdescs", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "profile_id"
    t.string   "description"
    t.boolean  "profile_admin"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "permission"
  end

  add_index "relationships", ["profile_id"], :name => "index_relationships_on_profile_id"
  add_index "relationships", ["user_id", "profile_id"], :name => "index_relationships_on_user_id_and_profile_id", :unique => true
  add_index "relationships", ["user_id"], :name => "index_relationships_on_user_id"

  create_table "storybook_questions", :force => true do |t|
    t.text     "question"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "useractionlogs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  :default => false
    t.string   "last_name"
    t.string   "first_name"
    t.boolean  "verified"
    t.string   "token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "invited_by"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
