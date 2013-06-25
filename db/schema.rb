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

ActiveRecord::Schema.define(:version => 20130625182620) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "comments"
    t.date     "done_by_date"
    t.boolean  "done"
    t.integer  "default_activity_id"
    t.integer  "user_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activity_reminders", :force => true do |t|
    t.string   "name"
    t.string   "mail"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "days_before"
    t.boolean  "sent"
  end

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "region_id"
    t.integer  "commune_id"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "ages", :force => true do |t|
    t.string   "range"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "album_photos", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "album_id"
    t.boolean  "visible",                        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "album_photo_image_file_name"
    t.string   "album_photo_image_content_type"
    t.integer  "album_photo_image_file_size"
    t.datetime "album_photo_image_updated_at"
  end

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.integer  "supplier_account_id"
    t.integer  "industry_category_id"
    t.boolean  "visible",              :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attached_files", :force => true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "attached_file_name"
    t.string   "attached_content_type"
    t.integer  "attached_file_size"
    t.datetime "attached_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachednotes", :force => true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bank_accounts", :force => true do |t|
    t.string   "owner_name"
    t.string   "owner_id"
    t.string   "owner_email"
    t.string   "bank"
    t.string   "account_type"
    t.string   "account_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_comments", :force => true do |t|
    t.string   "name"
    t.text     "comment"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", :force => true do |t|
    t.string   "status"
    t.string   "bookable_type"
    t.integer  "bookable_id"
    t.integer  "user_account_id"
    t.integer  "supplier_account_id"
    t.text     "message"
    t.string   "read"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bride_images", :force => true do |t|
    t.integer  "bride_id"
    t.string   "bride_file_name"
    t.string   "bride_content_type"
    t.integer  "bride_file_size"
    t.datetime "bride_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brides", :force => true do |t|
    t.string   "name"
    t.string   "lastname_p"
    t.string   "lastname_m"
    t.string   "rut"
    t.date     "born_date"
    t.string   "email"
    t.string   "phone"
    t.string   "cell_phone"
    t.string   "profession"
    t.integer  "user_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
  end

  create_table "budget_distribution_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_invitation_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_invitee_counts", :force => true do |t|
    t.integer  "user_account_id"
    t.integer  "budget_invitation_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "groom",                     :default => 100
    t.integer  "bride",                     :default => 100
    t.integer  "g_parents",                 :default => 100
    t.integer  "b_parents",                 :default => 100
  end

  create_table "budget_ranges", :force => true do |t|
    t.string   "range"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_slots", :force => true do |t|
    t.integer  "industry_category_id"
    t.integer  "budget_distribution_type_id"
    t.integer  "user_account_id"
    t.integer  "budget_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budgets", :force => true do |t|
    t.integer  "user_account_id"
    t.string   "budgetable_type"
    t.integer  "budgetable_id"
    t.integer  "budget_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "industry_category_id"
    t.string   "industry_category_name"
    t.string   "supplier_account_fantasy_name"
    t.integer  "supplier_account_id"
    t.integer  "price"
    t.integer  "budget_invitation_type_id"
    t.integer  "budget_slot_id"
  end

  create_table "campaign_anecdote_images", :force => true do |t|
    t.string   "anecdote_file_name"
    t.integer  "anecdote_file_size"
    t.string   "anecdote_content_type"
    t.datetime "anecdote_updated_at"
    t.integer  "campaign_anecdote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaign_anecdotes", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "campaign_anecdotes", ["slug"], :name => "index_campaign_anecdotes_on_slug"

  create_table "campaign_gallery_item_images", :force => true do |t|
    t.string   "gallery_item_file_name"
    t.string   "gallery_item_content_type"
    t.integer  "gallery_item_file_size"
    t.datetime "gallery_item_updated_at"
    t.integer  "campaign_gallery_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaign_gallery_items", :force => true do |t|
    t.string   "tag"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaign_user_account_infos", :force => true do |t|
    t.integer  "user_account_id"
    t.boolean  "approved_by_us",                   :default => false
    t.text     "description"
    t.string   "campaign_user_image_file_name"
    t.integer  "campaign_user_image_file_size"
    t.string   "campaign_user_image_content_type"
    t.datetime "campaign_user_image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ceremonies", :force => true do |t|
    t.integer  "address_id"
    t.string   "phone_number"
    t.string   "contact_email"
    t.string   "contact_person"
    t.string   "schedule"
    t.integer  "capacity"
    t.text     "additional_information"
    t.decimal  "price",                  :precision => 10, :scale => 0
    t.decimal  "top_price_range",        :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ceremony_type_id"
    t.string   "name"
  end

  create_table "ceremony_day_hours", :force => true do |t|
    t.integer  "ceremony_day_id"
    t.time     "hour"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ceremony_days", :force => true do |t|
    t.integer  "ceremony_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ceremony_images", :force => true do |t|
    t.integer  "ceremony_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ceremony_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenge_activities", :force => true do |t|
    t.integer  "matriclicker_id"
    t.integer  "challenge_id"
    t.integer  "challenge_activity_type_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenge_activity_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", :force => true do |t|
    t.integer  "matriclicker_id"
    t.integer  "lead_id"
    t.string   "name"
    t.date     "follow_up_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cloth_measures", :force => true do |t|
    t.float    "bust"
    t.float    "waist"
    t.float    "hips"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shoe_size_id"
    t.integer  "size_id"
  end

  create_table "cloth_measures_dresses", :id => false, :force => true do |t|
    t.integer  "dress_id"
    t.integer  "cloth_measure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "color_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communes", :force => true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dispatch_cost"
  end

  create_table "contact_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "company"
    t.string   "email"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "web_page_contact_state_id"
    t.text     "status_description"
  end

  create_table "contest_travelite_votes", :force => true do |t|
    t.integer  "contest_travelite_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "selection"
  end

  create_table "contest_travelites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "vote_count",                           :default => 0
    t.string   "selection"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contest_travelite_image_file_name"
    t.string   "contest_travelite_image_content_type"
    t.integer  "contest_travelite_image_file_size"
    t.datetime "contest_travelite_image_updated_at"
    t.string   "groom_name"
    t.string   "bride_name"
    t.string   "photo_name"
    t.string   "slug"
    t.integer  "position"
  end

  add_index "contest_travelites", ["slug"], :name => "index_contest_travelites_on_slug", :unique => true

  create_table "contest_vote_counts", :force => true do |t|
    t.integer  "vote_count"
    t.integer  "supplier_account_id"
    t.integer  "matri_dream_ic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contract_states", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contract_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", :force => true do |t|
    t.integer  "lead_id"
    t.string   "contract_number"
    t.integer  "contract_type_id"
    t.date     "signature_date"
    t.string   "invoice_rut"
    t.float    "price"
    t.float    "commission"
    t.date     "invoice_to"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "discount"
    t.date     "discount_start"
    t.date     "discount_end"
    t.date     "start_invoicing"
    t.integer  "contract_state_id"
    t.integer  "matriclicker_id"
    t.date     "end_contract_date"
    t.date     "invoice_from"
    t.boolean  "read_comments_before_invoice"
    t.boolean  "vat_free"
    t.integer  "quotas"
    t.date     "start_contract_date"
    t.text     "invoice_mailing"
    t.string   "expiration_comment"
  end

  create_table "conversations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "supplier_account_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "conversable_type"
    t.integer  "conversable_id"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_path"
  end

  create_table "countries_industry_categories", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "industry_category_id"
  end

  create_table "countries_sub_industry_categories", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "sub_industry_category_id"
  end

  create_table "couples", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credit_reductions", :force => true do |t|
    t.integer  "credit_id"
    t.integer  "purchase_id"
    t.integer  "value"
    t.date     "used_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credits", :force => true do |t|
    t.integer  "purchase_id"
    t.integer  "user_id"
    t.integer  "value"
    t.boolean  "active"
    t.text     "formula"
    t.date     "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cua_votes", :force => true do |t|
    t.integer  "campaign_user_account_info_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip"
  end

  create_table "days", :force => true do |t|
    t.integer  "day_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "weeks_length", :precision => 10, :scale => 0
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_invitee_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delivery_infos", :force => true do |t|
    t.string   "name"
    t.string   "rut"
    t.string   "contact_phone"
    t.string   "street"
    t.string   "number"
    t.integer  "commune_id"
    t.text     "additional_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "apartment"
  end

  create_table "delivery_methods", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dress_images", :force => true do |t|
    t.string   "dress_file_name"
    t.string   "dress_content_type"
    t.integer  "dress_file_size"
    t.datetime "dress_updated_at"
    t.integer  "dress_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dress_requests", :force => true do |t|
    t.integer  "dress_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dress_statuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dress_stock_sizes", :force => true do |t|
    t.integer  "dress_id"
    t.integer  "size_id"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dress_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dress_types_dresses", :id => false, :force => true do |t|
    t.integer  "dress_id"
    t.integer  "dress_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dress_types_sizes", :id => false, :force => true do |t|
    t.integer "dress_type_id"
    t.integer "size_id"
  end

  create_table "dresses", :force => true do |t|
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "color_id"
    t.integer  "supplier_account_id"
    t.text     "introduction"
    t.text     "care"
    t.text     "refund"
    t.string   "seller_name"
    t.string   "seller_phone_number"
    t.string   "seller_email"
    t.integer  "dress_status_id"
    t.integer  "position",            :default => 99
    t.string   "slug"
    t.string   "product_keywords"
  end

  add_index "dresses", ["slug"], :name => "index_dresses_on_slug", :unique => true

  create_table "dresses_gift_cards", :id => false, :force => true do |t|
    t.integer  "gift_card_id"
    t.integer  "dress_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dresses_tags", :id => false, :force => true do |t|
    t.integer  "dress_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "service_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.integer  "supplier_account_id"
    t.boolean  "booking_confirmed"
    t.integer  "user_account_id"
    t.boolean  "expired"
    t.integer  "user_id"
    t.boolean  "user_read",           :default => false
    t.string   "email"
    t.boolean  "related_confirm",     :default => false
    t.boolean  "supplier_read"
    t.boolean  "unconfirmed",         :default => false
    t.boolean  "watch",               :default => true
    t.boolean  "soft_deleted",        :default => false
  end

  create_table "expenses", :force => true do |t|
    t.integer  "user_account_id"
    t.integer  "supplier_account_id"
    t.integer  "product_id"
    t.integer  "service_id"
    t.integer  "price"
    t.string   "price_description"
    t.integer  "quantity"
    t.decimal  "payed_percentage",              :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "industry_category_name"
    t.string   "supplier_account_fantasy_name"
    t.integer  "industry_category_id"
    t.boolean  "wants_points",                                                 :default => false
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "web_page_contact_state_id"
    t.text     "status_description"
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "genders", :force => true do |t|
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gift_card_codes", :force => true do |t|
    t.string   "code"
    t.boolean  "bought"
    t.boolean  "used"
    t.integer  "gift_card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gift_card_statuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gift_cards", :force => true do |t|
    t.integer  "price"
    t.integer  "value"
    t.integer  "supplier_account_id"
    t.integer  "min_price"
    t.integer  "max_price"
    t.integer  "stock"
    t.integer  "gift_card_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "valid_from"
    t.date     "valid_to"
  end

  create_table "groom_images", :force => true do |t|
    t.integer  "groom_id"
    t.string   "groom_file_name"
    t.string   "groom_content_type"
    t.integer  "groom_file_size"
    t.datetime "groom_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grooms", :force => true do |t|
    t.string   "name"
    t.string   "lastname_p"
    t.string   "lastname_m"
    t.string   "rut"
    t.date     "born_date"
    t.string   "email"
    t.string   "phone"
    t.string   "cell_phone"
    t.string   "profession"
    t.integer  "user_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
  end

  create_table "important_dates", :force => true do |t|
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date_name"
    t.datetime "ends_date"
    t.boolean  "locked"
    t.integer  "supplier_account_id"
    t.string   "custom_message"
  end

  create_table "industry_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "industry_category_type_id"
    t.integer  "budget_priority"
    t.integer  "position"
    t.boolean  "hidden",                    :default => false
    t.boolean  "item_seller",               :default => false
    t.string   "slug"
  end

  add_index "industry_categories", ["slug"], :name => "index_industry_categories_on_slug", :unique => true

  create_table "industry_categories_supplier_accounts", :id => false, :force => true do |t|
    t.integer  "industry_category_id"
    t.integer  "supplier_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industry_category_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "user_account_id"
    t.text     "text"
    t.string   "background_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitee_groups", :force => true do |t|
    t.integer  "user_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "invitee_hosts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitee_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitees", :force => true do |t|
    t.string   "name"
    t.string   "lastname_p"
    t.string   "lastname_m"
    t.string   "phone_number"
    t.string   "email"
    t.boolean  "confirmed",        :default => false
    t.integer  "gender_id"
    t.integer  "age_id"
    t.integer  "status_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invitee_group_id"
    t.integer  "user_account_id"
    t.integer  "couple_id"
    t.integer  "invitee_host_id"
    t.integer  "invitee_role_id"
    t.integer  "invitation_id"
    t.boolean  "invitation_sent"
  end

  create_table "invoice_months", :force => true do |t|
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_months_invoices", :id => false, :force => true do |t|
    t.integer  "invoice_id"
    t.text     "invoice_month_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "contract_id"
    t.date     "issued_date"
    t.integer  "number"
    t.float    "net_price"
    t.float    "vat"
    t.boolean  "paid"
    t.date     "pay_date"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "collection_mail_sent"
    t.date     "date_collection_mail_sent"
  end

  create_table "lead_contacts", :force => true do |t|
    t.integer  "lead_id"
    t.string   "position"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cell_phone"
  end

  create_table "leads", :force => true do |t|
    t.integer  "matriclicker_id"
    t.string   "name"
    t.integer  "country_id"
    t.string   "webpage"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_account_id"
    t.integer  "industry_category_id"
  end

  create_table "mailings", :force => true do |t|
    t.datetime "date_sent"
    t.integer  "users_sent"
    t.datetime "dresses_start_date"
    t.datetime "dresses_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matri_dream_ics", :force => true do |t|
    t.integer  "industry_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matriclicker_statuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matriclickers", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "role"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "matriclicker_status_id"
  end

  create_table "matriclickers_privileges", :id => false, :force => true do |t|
    t.integer  "matriclicker_id"
    t.integer  "privilege_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "conversation_id"
    t.string   "transmitter"
    t.text     "content"
    t.boolean  "user_read"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "supplier_read"
    t.boolean  "is_supplier"
  end

  create_table "no_more_bookings", :force => true do |t|
    t.integer  "no_more_bookable_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "no_more_bookable_type"
  end

  create_table "opportunities", :force => true do |t|
    t.string   "title"
    t.text     "introduction"
    t.text     "description"
    t.string   "main_image_file_name"
    t.string   "main_image_content_type"
    t.string   "main_image_file_size"
    t.string   "main_image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "valid_until"
    t.integer  "supplier_account_id"
    t.string   "side_image_file_name"
    t.string   "side_image_content_type"
    t.string   "side_image_file_size"
    t.string   "side_image_updated_at"
    t.string   "slug"
  end

  add_index "opportunities", ["slug"], :name => "index_opportunities_on_slug", :unique => true

  create_table "opportunity_images", :force => true do |t|
    t.integer  "opportunity_id"
    t.string   "caption"
    t.string   "opportunity_image_file_name"
    t.string   "opportunity_image_content_type"
    t.string   "opportunity_image_file_size"
    t.string   "opportunity_image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "tbk_tipo_transaccion"
    t.string   "tbk_respuesta"
    t.string   "tbk_id_sesion"
    t.string   "tbk_codigo_autorizacion"
    t.string   "tbk_monto"
    t.string   "tbk_final_numero_tarjeta"
    t.string   "tbk_fecha_expiracion"
    t.string   "tbk_fecha_contable"
    t.string   "tbk_fecha_transaccion"
    t.string   "tbk_hora_transaccion"
    t.string   "tbk_id_transaccion"
    t.string   "tbk_tipo_pago"
    t.string   "tbk_numero_cuotas"
    t.string   "tbk_mac"
    t.string   "tbk_tasa_interes_max"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "tbk_orden_compra"
    t.string   "matri_result"
    t.integer  "purchase_id"
  end

  create_table "pack_promotions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "link"
    t.string   "pack_promotion_image_file_name"
    t.string   "pack_promotion_image_content_type"
    t.integer  "pack_promotion_image_file_size"
    t.datetime "pack_promotion_image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "pack_promotions_posts", :id => false, :force => true do |t|
    t.integer "pack_promotion_id"
    t.integer "post_id"
  end

  create_table "payer_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payers", :force => true do |t|
    t.integer  "expense_id"
    t.decimal  "percentage",    :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payer_type_id"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "lastname_p"
    t.string   "lastname_m"
    t.string   "rut"
    t.string   "email"
    t.integer  "user_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_contents", :force => true do |t|
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_images", :force => true do |t|
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "post_content_id"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "introduction"
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "industry_category_id"
    t.string   "main_image_file_name"
    t.string   "main_image_content_type"
    t.integer  "main_image_file_size"
    t.datetime "main_image_updated_at"
    t.boolean  "visible"
    t.integer  "country_id",              :default => 1
    t.string   "post_type"
    t.string   "product_keywords"
  end

  add_index "posts", ["slug"], :name => "index_posts_on_slug"

  create_table "presentation_images", :force => true do |t|
    t.integer  "presentation_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presentations", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_account_id"
  end

  create_table "privileges", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_budgets", :force => true do |t|
    t.integer  "user_account_id"
    t.integer  "product_id"
    t.integer  "budget_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "included"
  end

  create_table "product_faqs", :force => true do |t|
    t.string   "question"
    t.string   "answer"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_images", :force => true do |t|
    t.integer  "product_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",             :default => true
    t.integer  "image_index"
  end

  create_table "product_types", :force => true do |t|
    t.integer  "industry_category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.integer  "supplier_account_id"
    t.integer  "product_type_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",                      :precision => 10, :scale => 0, :default => 0
    t.string   "price_description"
    t.decimal  "top_price_range",            :precision => 10, :scale => 0, :default => 0
    t.integer  "industry_category_id"
    t.integer  "booking_resources_consumed",                                :default => 1
    t.integer  "discount",                                                  :default => 0
    t.integer  "place"
    t.string   "slug"
  end

  create_table "purchases", :force => true do |t|
    t.integer  "purchasable_id"
    t.string   "purchasable_type"
    t.integer  "user_id"
    t.integer  "delivery_info_id"
    t.float    "price"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed_terms"
    t.string   "status",               :default => "inicial"
    t.date     "delivery_date"
    t.string   "transfer_type"
    t.integer  "delivery_cost"
    t.string   "dispatch_address"
    t.string   "size"
    t.integer  "quantity"
    t.integer  "delivery_method_id"
    t.float    "delivery_method_cost"
    t.float    "purchasable_price"
    t.float    "credits_used"
  end

  create_table "reference_requests", :force => true do |t|
    t.integer  "service_id"
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "supplier_account_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id"
  end

  create_table "refund_reasons", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refund_requests", :force => true do |t|
    t.integer  "refund_reason_id"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_owner_name"
    t.string   "account_owner_id"
    t.string   "account_owner_email"
    t.string   "account_bank"
    t.string   "account_type"
    t.string   "account_number"
    t.integer  "dress_id"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rent_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reserved_dates", :force => true do |t|
    t.date     "date"
    t.integer  "supplier_account_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.text     "content"
    t.string   "reviewable_type"
    t.integer  "reviewable_id"
    t.boolean  "supplier_read",     :default => false
    t.integer  "user_id"
    t.boolean  "approved_by_admin", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rocks", :force => true do |t|
    t.integer  "gender_id"
    t.string   "sender_email"
    t.string   "recipient_email"
    t.string   "sender_name"
    t.string   "recipient_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_images", :force => true do |t|
    t.integer  "room_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",             :default => true
    t.integer  "image_index"
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.integer  "max_capacity"
    t.integer  "rent_cost"
    t.integer  "rent_type_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_day_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_days", :force => true do |t|
    t.integer  "day_id"
    t.integer  "schedule_id"
    t.time     "from"
    t.time     "to"
    t.boolean  "enabled"
    t.boolean  "all_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "start_lunch_time"
    t.time     "end_lunch_time"
    t.integer  "schedule_day_type_id"
  end

  create_table "schedules", :force => true do |t|
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_budgets", :force => true do |t|
    t.integer  "user_account_id"
    t.integer  "service_id"
    t.integer  "budget_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "included"
  end

  create_table "service_faqs", :force => true do |t|
    t.string   "question"
    t.string   "answer"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_images", :force => true do |t|
    t.integer  "service_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",             :default => true
    t.integer  "image_index"
  end

  create_table "services", :force => true do |t|
    t.integer  "supplier_account_id"
    t.string   "address"
    t.string   "contact_phone"
    t.string   "commune"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "color_type_id"
    t.integer  "max_bookings",                                              :default => 3
    t.integer  "max_confirmed_bookings",                                    :default => 2
    t.string   "parking"
    t.boolean  "deliverable"
    t.string   "name"
    t.integer  "industry_category_id"
    t.text     "description"
    t.decimal  "price",                      :precision => 10, :scale => 0, :default => 0
    t.string   "price_description"
    t.decimal  "top_price_range",            :precision => 10, :scale => 0, :default => 0
    t.integer  "booking_resources_consumed",                                :default => 1
    t.integer  "discount",                                                  :default => 0
    t.integer  "place"
    t.string   "slug"
  end

  create_table "shoe_sizes", :force => true do |t|
    t.float    "size_cl"
    t.float    "size_us"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopping_cart_items", :force => true do |t|
    t.integer  "shopping_cart_id"
    t.integer  "purchasable_id"
    t.string   "purchasable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "size"
    t.integer  "quantity"
  end

  create_table "shopping_carts", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slider_image_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slider_images", :force => true do |t|
    t.integer  "slider_image_type_id"
    t.string   "slider_image_file_name"
    t.string   "slider_image_content_type"
    t.string   "slider_image_file_size"
    t.string   "slider_image_updated_at"
    t.string   "title"
    t.text     "content"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "country_id"
    t.boolean  "target"
  end

  create_table "star_ratings", :force => true do |t|
    t.integer  "value"
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "statuses", :force => true do |t|
    t.string   "status"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_industry_categories", :force => true do |t|
    t.integer  "industry_category_id"
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_industry_categories_supplier_accounts", :id => false, :force => true do |t|
    t.integer  "sub_industry_category_id"
    t.integer  "supplier_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriber_preferences", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriber_preferences_subscribers", :id => false, :force => true do |t|
    t.integer  "subscriber_id"
    t.integer  "subscriber_preference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commune_id"
    t.string   "url_coming_from"
  end

  create_table "supplier_account_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_accounts", :force => true do |t|
    t.integer  "supplier_id"
    t.string   "corporate_name"
    t.string   "web_page"
    t.string   "fantasy_name"
    t.string   "rut"
    t.string   "phone_number"
    t.string   "addressf"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved_by_us",            :default => false
    t.string   "public_url"
    t.boolean  "mail_sent",                 :default => false
    t.boolean  "approved_by_supplier",      :default => false
    t.boolean  "bookable",                  :default => true
    t.integer  "booking_resources",         :default => 3
    t.integer  "booking_waiting_list_size", :default => 5
    t.integer  "reviews_count",             :default => 0
    t.string   "facebook"
    t.string   "twiter"
    t.integer  "supplier_account_type_id"
    t.string   "address_region"
    t.string   "address_commune"
    t.integer  "address_id"
    t.boolean  "online_payment"
    t.integer  "country_id",                :default => 1
  end

  create_table "supplier_contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.integer  "contact_type_id"
    t.integer  "supplier_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_page_views", :force => true do |t|
    t.integer  "supplier_account_id"
    t.integer  "count"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "view_count_type_id"
  end

  create_table "supplier_without_accounts", :force => true do |t|
    t.string   "corporate_name"
    t.string   "web_page"
    t.string   "fantasy_name"
    t.string   "phone_number"
    t.string   "address"
    t.integer  "industry_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "email",                                 :default => "",   :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language",                              :default => "es"
    t.integer  "country_id",                            :default => 1
  end

  add_index "suppliers", ["email"], :name => "index_suppliers_on_email", :unique => true
  add_index "suppliers", ["reset_password_token"], :name => "index_suppliers_on_reset_password_token", :unique => true

  create_table "tag_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image_name"
    t.integer  "tag_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tentative_budgets", :force => true do |t|
    t.integer  "budget_range_id"
    t.integer  "user_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", :force => true do |t|
    t.text     "question"
    t.text     "answer"
    t.integer  "ceremony_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trading_houses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_account_activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "comments"
    t.date     "done_by_date"
    t.boolean  "done"
    t.integer  "default_activity_id"
    t.integer  "user_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_account_images", :force => true do |t|
    t.integer  "user_account_id"
    t.string   "couple_file_name"
    t.string   "couple_content_type"
    t.integer  "couple_file_size"
    t.datetime "couple_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_account_trading_houses", :force => true do |t|
    t.integer  "user_account_id"
    t.integer  "trading_house_id"
    t.string   "trading_house_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_accounts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "wedding_tentative_date"
    t.string   "wedding_city"
    t.boolean  "receive_news"
    t.boolean  "receive_supplier_promotions"
    t.boolean  "show_my_phones"
    t.boolean  "in_campaign",                 :default => false
    t.boolean  "did_review",                  :default => false
    t.integer  "budget_distribution_type_id"
    t.integer  "invitees_quantity"
    t.integer  "country_id",                  :default => 1
  end

  create_table "user_contest_selections", :force => true do |t|
    t.integer  "user_id"
    t.integer  "supplier_account_id"
    t.integer  "matri_dream_ic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "language"
    t.integer  "user_account_id"
    t.boolean  "is_owner"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "country_id",                            :default => 1
    t.integer  "cloth_measure_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "videoable_type"
    t.integer  "videoable_id"
    t.string   "url_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "view_count_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "webpage_contact_states", :force => true do |t|
    t.string   "status"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wed_benchmarks", :force => true do |t|
    t.integer  "industry_category_id"
    t.decimal  "precentage",           :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wedding_planner_quotes", :force => true do |t|
    t.string   "nombre_novia"
    t.string   "fono_novia"
    t.string   "nombre_novio"
    t.string   "fono_novio"
    t.date     "fecha_del_matrimonio"
    t.string   "cantidad_de_invitados"
    t.string   "presupuesto_banqueteria"
    t.string   "presupuesto_centro_de_eventos"
    t.string   "presupuesto_iglesia"
    t.string   "presupuesto_civil"
    t.string   "presupuesto_coro"
    t.string   "presupuesto_flores"
    t.string   "presupuesto_arriendo_auto"
    t.string   "presupuesto_decoracion_salon"
    t.string   "presupuesto_musica_iluminacion"
    t.string   "presupuesto_argollas"
    t.string   "presupuesto_fotografia"
    t.string   "presupuesto_video"
    t.string   "presupuesto_animacion"
    t.string   "presupuesto_cotillon"
    t.string   "presupuesto_partes_de_matrimonio"
    t.string   "presupuesto_torta_de_novios"
    t.string   "presupuesto_recuerdo_matrimonio"
    t.string   "presupuesto_vinos"
    t.string   "presupuesto_bar_destilados"
    t.string   "presupuesto_vestido_novia"
    t.string   "presupuesto_maquillaje"
    t.string   "presupuesto_peinado"
    t.string   "presupuesto_tocado"
    t.string   "presupuesto_ramo_de_novia"
    t.string   "presupuesto_zapatos_novia"
    t.string   "presupuesto_traje_novio"
    t.string   "presupuesto_camisa_a_medida"
    t.string   "presupuesto_extras"
    t.text     "comentarios_adicionales"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "presupuesto_zapatos_novio"
    t.string   "email_novio"
    t.string   "email_novia"
  end

end
