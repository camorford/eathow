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

ActiveRecord::Schema.define(version: 20141209000830) do

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipe_id"
  end

  add_index "favorites", ["recipe_id"], name: "index_favorites_on_recipe_id"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_ingredients", force: true do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipe_ingredients", ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
  add_index "recipe_ingredients", ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.text     "directions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "carbs"
    t.integer  "protein"
    t.integer  "fat"
    t.integer  "calories"
    t.string   "picture"
    t.string   "nutrition_picture"
  end

  create_table "user_ingredients", force: true do |t|
    t.integer  "user_id"
    t.integer  "ingredient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_ingredients", ["ingredient_id"], name: "index_user_ingredients_on_ingredient_id"
  add_index "user_ingredients", ["user_id"], name: "index_user_ingredients_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "protein"
    t.integer  "carbs"
    t.integer  "fat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calories"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
