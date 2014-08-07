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

ActiveRecord::Schema.define(version: 20140807192434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "locationer_locations", force: true do |t|
    t.string   "name"
    t.string   "asciiname"
    t.text     "alternatenames"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "feature_class"
    t.string   "feature_code"
    t.string   "country_code"
    t.string   "admin1_code"
    t.integer  "population"
    t.string   "timezone"
    t.datetime "modification_date"
  end

  add_index "locationer_locations", ["admin1_code"], name: "index_locationer_locations_on_admin1_code", using: :btree
  add_index "locationer_locations", ["asciiname"], name: "index_locationer_locations_on_asciiname", using: :btree
  add_index "locationer_locations", ["feature_class"], name: "index_locationer_locations_on_feature_class", using: :btree
  add_index "locationer_locations", ["feature_code"], name: "index_locationer_locations_on_feature_code", using: :btree
  add_index "locationer_locations", ["latitude"], name: "index_locationer_locations_on_latitude", using: :btree
  add_index "locationer_locations", ["longitude"], name: "index_locationer_locations_on_longitude", using: :btree

end
