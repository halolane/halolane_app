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

ActiveRecord::Schema.define(:version => 20130808204539) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bookshelfrelations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bookshelf_id"
    t.string   "permission"
    t.boolean  "owner"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "bookshelfrelations", ["bookshelf_id"], :name => "index_bookshelfrelations_on_bookshelf_id"
  add_index "bookshelfrelations", ["user_id", "bookshelf_id"], :name => "index_bookshelfrelations_on_user_id_and_bookshelf_id", :unique => true
  add_index "bookshelfrelations", ["user_id"], :name => "index_bookshelfrelations_on_user_id"

  create_table "bookshelves", :force => true do |t|
    t.string   "name"
    t.integer  "privacy"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  create_table "chapters", :force => true do |t|
    t.integer  "profile_id"
    t.string   "chapter_name"
    t.integer  "chapter_num"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "subtype"
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
    t.integer  "bookshelf_id"
    t.string   "invite_type"
  end

  create_table "likememories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "memory_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memories", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "profile_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.date     "date"
    t.boolean  "has_photo"
    t.integer  "page_id"
    t.integer  "tile_num"
    t.string   "description"
    t.string   "title"
  end

  add_index "memories", ["profile_id", "created_at"], :name => "index_memories_on_profile_id_and_created_at"
  add_index "memories", ["user_id", "created_at"], :name => "index_memories_on_user_id_and_created_at"
  add_index "memories", ["user_id", "profile_id", "created_at"], :name => "index_memories_on_user_profile_created"

  create_table "memoryphotos", :force => true do |t|
    t.integer  "memory_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "page_num"
    t.integer  "chapter_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "template_id"
  end

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.date     "deathday"
    t.integer  "privacy"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "slug"
    t.string   "url"
    t.integer  "bookshelf_id"
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
    t.boolean  "owner"
  end

  add_index "relationships", ["profile_id"], :name => "index_relationships_on_profile_id"
  add_index "relationships", ["user_id", "profile_id"], :name => "index_relationships_on_user_id_and_profile_id", :unique => true
  add_index "relationships", ["user_id"], :name => "index_relationships_on_user_id"

  create_table "storybook_questions", :force => true do |t|
    t.text     "question"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "subtype"
    t.integer  "tile_num"
  end

  create_table "storycomments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "memory_id"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "templates", :force => true do |t|
    t.string   "description"
    t.integer  "height"
    t.integer  "width"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "template_num"
  end

  create_table "tiles", :force => true do |t|
    t.integer  "template_id"
    t.integer  "datarow"
    t.integer  "datacol"
    t.integer  "datasizex"
    t.integer  "datasizey"
    t.integer  "tile_num"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "height"
    t.integer  "width"
  end

  create_table "useractionlogs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "pages"
    t.string   "action"
    t.integer  "profile_id"
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
    t.boolean  "newfeature"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
