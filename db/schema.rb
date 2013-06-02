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

ActiveRecord::Schema.define(:version => 20130602201147) do

  create_table "bookmarks", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.text     "comments"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "tag_names"
    t.string   "image_url"
  end

  add_index "bookmarks", ["url"], :name => "index_bookmarks_on_url", :unique => true

  create_table "bookmarks_tags", :id => false, :force => true do |t|
    t.integer "bookmark_id"
    t.integer "tag_id"
  end

  add_index "bookmarks_tags", ["bookmark_id", "tag_id"], :name => "index_bookmarks_tags_on_bookmark_id_and_tag_id", :unique => true

  create_table "oembeds", :force => true do |t|
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

end
