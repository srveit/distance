# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080718223948) do

  create_table "zip_codes", :force => true do |t|
    t.string   "zip_code"
    t.string   "state_abbreviation"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zip_codes", ["zip_code"], :name => "index_zip_code_on_zip_codes"
  add_index "zip_codes", ["latitude"], :name => "index_latitude_on_zip_codes"
  add_index "zip_codes", ["longitude"], :name => "index_longitude_on_zip_codes"

end
