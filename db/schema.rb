ActiveRecord::Schema.define(version: 20140603220452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: true do |t|
    t.string   "url"
    t.string   "handle"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
