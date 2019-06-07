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

ActiveRecord::Schema.define(version: 20190607065039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorizations", force: :cascade do |t|
    t.bigint "reminder_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categorizations_on_category_id"
    t.index ["reminder_id"], name: "index_categorizations_on_reminder_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "requester_id"
    t.integer "receiver_id"
    t.boolean "request_accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_genres", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_movie_genres_on_genre_id"
    t.index ["movie_id"], name: "index_movie_genres_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "poster_path"
    t.boolean "adult"
    t.string "overview"
    t.string "release_date"
    t.string "title"
    t.string "original_language"
    t.integer "vote_count"
    t.float "vote_average"
    t.string "backdrop_path"
    t.float "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reminders", force: :cascade do |t|
    t.string "content"
    t.datetime "dueDate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "complete"
    t.datetime "dateCompleted"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "avatarUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "categorizations", "categories"
  add_foreign_key "categorizations", "reminders"
  add_foreign_key "movie_genres", "genres"
  add_foreign_key "movie_genres", "movies"
end
