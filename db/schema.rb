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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151215094024) do

  create_table "placeholder_images", force: :cascade do |t|
    t.integer  "native_width",       null: false
    t.integer  "native_height",      null: false
    t.integer  "image_category",     null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "placeholder_images", ["image_category"], name: "index_placeholder_images_on_image_category"
  add_index "placeholder_images", ["native_height"], name: "index_placeholder_images_on_native_height"
  add_index "placeholder_images", ["native_width"], name: "index_placeholder_images_on_native_width"

end
