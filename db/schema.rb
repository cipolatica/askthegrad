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

ActiveRecord::Schema.define(version: 20160319172623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "college_id"
    t.integer  "major_id"
    t.integer  "counter"
    t.text     "content"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "college_review_id"
    t.integer  "major_review_id"
    t.integer  "register_id"
    t.boolean  "is_parent"
    t.string   "lineage"
    t.integer  "comm_id"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "reason"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "major_reviews", force: true do |t|
    t.integer  "school_id"
    t.integer  "year_graduated"
    t.boolean  "recommend_this_major"
    t.float    "difficulty"
    t.float    "rating"
    t.float    "annual_salary"
    t.integer  "user_id"
    t.boolean  "worth_money"
    t.float    "debt"
    t.text     "review"
    t.string   "title"
    t.string   "position_title"
    t.integer  "register_id"
    t.integer  "vote_count"
    t.integer  "comment_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "major_id"
  end

  create_table "major_search_suggestions", force: true do |t|
    t.string   "term"
    t.integer  "popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "majors", force: true do |t|
    t.integer  "state_id"
    t.string   "name"
    t.string   "city"
    t.float    "rating_average"
    t.float    "salary_average"
    t.float    "recommend_average"
    t.float    "difficulty_average"
    t.float    "worth_money_average"
    t.float    "debt_average"
    t.float    "college_counter"
    t.float    "major_counter"
    t.float    "two_year_college"
    t.float    "two_year_major"
    t.string   "searchable"
    t.string   "searchable_name"
    t.integer  "popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "top_school_ids"
    t.string   "top_school_names"
    t.string   "top_school_amounts"
    t.float    "overall_salary"
  end

  create_table "registrations", force: true do |t|
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "school_review_id"
    t.integer  "major_id"
    t.integer  "major_review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comment_id"
  end

  create_table "rooms", force: true do |t|
    t.string   "topic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rs_evaluations", force: true do |t|
    t.string   "reputation_name"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.float    "value",           default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], name: "index_rs_evaluations_on_reputation_name_and_source_and_target", unique: true, using: :btree
  add_index "rs_evaluations", ["reputation_name"], name: "index_rs_evaluations_on_reputation_name", using: :btree
  add_index "rs_evaluations", ["source_id", "source_type"], name: "index_rs_evaluations_on_source_id_and_source_type", using: :btree
  add_index "rs_evaluations", ["target_id", "target_type"], name: "index_rs_evaluations_on_target_id_and_target_type", using: :btree

  create_table "rs_reputation_messages", force: true do |t|
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.float    "weight",      default: 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], name: "index_rs_reputation_messages_on_receiver_id_and_sender", unique: true, using: :btree
  add_index "rs_reputation_messages", ["receiver_id"], name: "index_rs_reputation_messages_on_receiver_id", using: :btree
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], name: "index_rs_reputation_messages_on_sender_id_and_sender_type", using: :btree

  create_table "rs_reputations", force: true do |t|
    t.string   "reputation_name"
    t.float    "value",           default: 0.0
    t.string   "aggregated_by"
    t.integer  "target_id"
    t.string   "target_type"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], name: "index_rs_reputations_on_reputation_name_and_target", unique: true, using: :btree
  add_index "rs_reputations", ["reputation_name"], name: "index_rs_reputations_on_reputation_name", using: :btree
  add_index "rs_reputations", ["target_id", "target_type"], name: "index_rs_reputations_on_target_id_and_target_type", using: :btree

  create_table "school_reviews", force: true do |t|
    t.integer  "school_id"
    t.integer  "year_graduated"
    t.boolean  "recommend_this_school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating"
    t.float    "annual_salary"
    t.integer  "user_id"
    t.boolean  "worth_money"
    t.float    "debt"
    t.text     "review"
    t.string   "title"
    t.integer  "register_id"
    t.integer  "vote_count"
    t.integer  "comment_count"
    t.float    "party_school"
    t.integer  "major_id"
    t.string   "position_title"
    t.float    "school_rating"
    t.float    "major_rating"
    t.float    "difficulty"
    t.boolean  "recommend_this_major"
    t.float    "career_satisfaction"
    t.boolean  "career_relation"
    t.string   "rating_f"
    t.string   "difficulty_f"
    t.string   "party_school_f"
    t.string   "major_name"
    t.string   "user_name"
    t.string   "school_name"
    t.string   "salary_string"
    t.string   "debt_string"
    t.text     "school_review"
    t.float    "current_salary"
    t.string   "current_salary_string"
  end

  create_table "schools", force: true do |t|
    t.integer  "state_id"
    t.string   "name"
    t.string   "acronym"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating_average"
    t.float    "salary_average"
    t.float    "recommend_average"
    t.float    "party_average"
    t.float    "worth_money_average"
    t.float    "debt_average"
    t.integer  "college_counter"
    t.integer  "major_counter"
    t.integer  "two_year_college"
    t.integer  "two_year_major"
    t.string   "searchable"
    t.string   "searchable_name"
    t.integer  "popularity"
    t.string   "top_major_ids"
    t.string   "top_major_names"
    t.string   "top_major_amounts"
    t.float    "overall_salary"
  end

  create_table "search_suggestions", force: true do |t|
    t.string   "term"
    t.integer  "popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", force: true do |t|
    t.string   "name"
    t.text     "top_college_salary_names"
    t.text     "top_college_salary_amounts"
    t.text     "top_college_salary_ids"
    t.text     "top_college_debt_names"
    t.text     "top_college_debt_amounts"
    t.text     "top_college_debt_ids"
    t.text     "top_college_recommend_names"
    t.text     "top_college_recommend_amounts"
    t.text     "top_college_recommend_ids"
    t.text     "top_college_rating_names"
    t.text     "top_college_rating_amounts"
    t.text     "top_college_rating_ids"
    t.text     "top_college_worth_money_names"
    t.text     "top_college_worth_money_amounts"
    t.text     "top_college_worth_money_ids"
    t.text     "top_college_party_school_names"
    t.text     "top_college_party_amounts"
    t.text     "top_college_party_ids"
    t.text     "top_major_rating_names"
    t.text     "top_major_rating_amounts"
    t.text     "top_major_rating_ids"
    t.text     "top_major_difficulty_names"
    t.text     "top_major_difficulty_amounts"
    t.text     "top_major_difficulty_ids"
    t.text     "top_major_recommend_names"
    t.text     "top_major_recommend_amounts"
    t.text     "top_major_recommend_ids"
    t.text     "top_major_salary_names"
    t.text     "top_major_salary_amounts"
    t.text     "top_major_salary_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "top_college_party_school_amounts"
    t.text     "top_college_party_school_ids"
    t.text     "m_diff_names"
    t.text     "m_diff_amounts"
    t.text     "m_diff_ids"
    t.text     "m_rec_names"
    t.text     "m_rec_amounts"
    t.text     "m_rec_ids"
    t.text     "m_sal_names"
    t.text     "m_sal_amounts"
    t.text     "m_sal_ids"
    t.text     "c_overall_sal_names"
    t.text     "c_overall_sal_ids"
    t.text     "c_overall_sal_amounts"
    t.text     "m_overall_sal_names"
    t.text     "m_overall_sal_amounts"
    t.text     "m_overall_sal_ids"
  end

  create_table "unauthenticated_reviews", force: true do |t|
    t.integer  "school_id"
    t.integer  "year_graduated"
    t.boolean  "recommend_this_school"
    t.boolean  "worth_money"
    t.float    "debt"
    t.text     "review"
    t.string   "title"
    t.float    "party_school"
    t.integer  "major_id"
    t.string   "position_title"
    t.float    "school_rating"
    t.float    "major_rating"
    t.float    "difficulty"
    t.boolean  "recommend_this_major"
    t.float    "career_satisfaction"
    t.boolean  "career_relation"
    t.string   "major_name"
    t.string   "school_name"
    t.text     "school_review"
    t.float    "current_salary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating"
    t.float    "annual_salary"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "username"
    t.integer  "reg"
    t.text     "review_list"
    t.text     "review_daily_count"
    t.text     "email_daily_count"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "college_id"
    t.integer  "major_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "years", force: true do |t|
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
