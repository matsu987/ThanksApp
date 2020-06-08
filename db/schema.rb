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

ActiveRecord::Schema.define(version: 2020_03_17_034434) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text", null: false
    t.bigint "user_id"
    t.bigint "thank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thank_id"], name: "index_comments_on_thank_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "post_number"
    t.text "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_companies_on_name"
  end

  create_table "group_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.integer "rank", default: 0, null: false
    t.boolean "enrollment", default: true, null: false
    t.integer "status", default: 0, null: false
    t.boolean "request", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "ancestry"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_groups_on_company_id"
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "recomend_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "recomendation_id"
    t.bigint "user_id"
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recomendation_id"], name: "index_recomend_comments_on_recomendation_id"
    t.index ["user_id"], name: "index_recomend_comments_on_user_id"
  end

  create_table "recomendations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "recomender_id"
    t.bigint "electeder_id"
    t.boolean "decision", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["electeder_id"], name: "index_recomendations_on_electeder_id"
    t.index ["recomender_id"], name: "index_recomendations_on_recomender_id"
  end

  create_table "thank_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "thank_id"
    t.boolean "like", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sender_id"], name: "index_thank_likes_on_sender_id"
    t.index ["thank_id"], name: "index_thank_likes_on_thank_id"
  end

  create_table "thanks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text", null: false
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.boolean "transmisson_status", default: false, null: false
    t.boolean "reception_status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_thanks_on_receiver_id"
    t.index ["sender_id"], name: "index_thanks_on_sender_id"
  end

  create_table "user_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.boolean "like", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_user_likes_on_receiver_id"
    t.index ["sender_id"], name: "index_user_likes_on_sender_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.text "introduction"
    t.string "avatar"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "thanks"
  add_foreign_key "comments", "users"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "groups", "companies"
  add_foreign_key "recomend_comments", "recomendations"
  add_foreign_key "recomend_comments", "users"
  add_foreign_key "recomendations", "users", column: "electeder_id"
  add_foreign_key "recomendations", "users", column: "recomender_id"
  add_foreign_key "thank_likes", "thanks"
  add_foreign_key "thank_likes", "users", column: "sender_id"
  add_foreign_key "thanks", "users", column: "receiver_id"
  add_foreign_key "thanks", "users", column: "sender_id"
  add_foreign_key "user_likes", "users", column: "receiver_id"
  add_foreign_key "user_likes", "users", column: "sender_id"
end
