# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2014_07_01_215412) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: :cascade do |t|
    t.string "url"
    t.string "handle"
    t.string "content"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tweet_id"
    t.index ["tweet_id"], name: "index_tweets_users_on_tweet_id"
    t.index ["user_id"], name: "index_tweets_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "handle"
    t.string "twitter_token"
    t.string "twitter_token_secret"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
