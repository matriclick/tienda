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

ActiveRecord::Schema.define(:version => 20131112013842) do

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

  create_table "contest_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contestant_id"
    t.integer  "contest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contestant_images", :force => true do |t|
    t.integer  "contestant_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "contestants", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "introduction"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contest_id"
  end

  add_index "contestants", ["slug"], :name => "index_contestants_on_slug", :unique => true

  create_table "contests", :force => true do |t|
    t.string   "name"
    t.text     "instructions"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "status"
  end

  add_index "contests", ["slug"], :name => "index_competitions_on_slug", :unique => true

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

  create_table "dress_statuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dress_stock_change_notifications", :force => true do |t|
    t.integer  "dress_id"
    t.integer  "size_id"
    t.string   "color"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "dress_stock_sizes", :force => true do |t|
    t.integer  "dress_id"
    t.integer  "size_id"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
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
    t.integer  "dress_status_id"
    t.integer  "position",            :default => 99
    t.string   "slug"
    t.string   "product_keywords"
    t.float    "net_cost"
    t.float    "vat_cost"
    t.integer  "original_price"
    t.float    "discount"
    t.string   "code"
    t.boolean  "fix_cost"
  end

  add_index "dresses", ["slug"], :name => "index_dresses_on_slug", :unique => true

  create_table "dresses_gift_cards", :id => false, :force => true do |t|
    t.integer  "gift_card_id"
    t.integer  "dress_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dresses_refund_requests", :id => false, :force => true do |t|
    t.integer "dress_id"
    t.integer "refund_request_id"
  end

  create_table "dresses_tags", :id => false, :force => true do |t|
    t.integer  "dress_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dresses_users_wish_lists", :force => true do |t|
    t.integer  "dress_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "industry_categories_supplier_accounts", :id => false, :force => true do |t|
    t.integer  "industry_category_id"
    t.integer  "supplier_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_months_invoices", :id => false, :force => true do |t|
    t.integer  "invoice_id"
    t.text     "invoice_month_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logistic_providers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
  end

  create_table "mailings", :force => true do |t|
    t.datetime "date_sent"
    t.integer  "users_sent"
    t.datetime "dresses_start_date"
    t.datetime "dresses_end_date"
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

  create_table "pack_promotions_posts", :id => false, :force => true do |t|
    t.integer "pack_promotion_id"
    t.integer "post_id"
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
    t.string   "post_type"
    t.string   "product_keywords"
    t.integer  "country_id"
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
    t.string   "tracking_number"
    t.integer  "logistic_provider_id"
    t.boolean  "funds_received"
    t.boolean  "store_paid"
    t.boolean  "refunded"
    t.float    "refund_value"
    t.float    "total_cost"
    t.float    "actual_delivery_cost"
    t.date     "refund_date"
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

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", :force => true do |t|
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.float    "total_cost"
    t.boolean  "refunded"
    t.integer  "price"
    t.integer  "unit_cost"
    t.boolean  "store_paid"
    t.string   "color"
  end

  create_table "shopping_cart_items_store_payments", :id => false, :force => true do |t|
    t.integer "shopping_cart_item_id"
    t.integer "store_payment_id"
  end

  create_table "shopping_carts", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_configurations", :force => true do |t|
    t.boolean  "clearance_menu"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contest_id"
    t.integer  "free_shipping_from_price"
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

  create_table "store_payments", :force => true do |t|
    t.integer  "amount"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rut"
    t.string   "account_owner_name"
    t.string   "account_owner_email"
    t.string   "account_bank"
    t.string   "account_number"
    t.string   "account_type"
    t.integer  "supplier_account_id"
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
    t.string   "account_owner_name"
    t.string   "account_number"
    t.string   "account_bank"
    t.string   "account_type"
    t.string   "account_owner_email"
    t.float    "net_margin"
    t.integer  "country_id"
  end

  create_table "supplier_accounts_users", :id => false, :force => true do |t|
    t.integer "supplier_account_id"
    t.integer "user_id"
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
    t.integer  "country_id"
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
    t.integer  "country_id"
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
    t.integer  "cloth_measure_id"
    t.integer  "country_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wbr_data", :force => true do |t|
    t.integer  "year"
    t.integer  "week"
    t.integer  "fb_followers"
    t.integer  "webpage_visits"
    t.integer  "newsletters_sent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fb_organic_reach"
  end

  create_table "wed_benchmarks", :force => true do |t|
    t.integer  "industry_category_id"
    t.decimal  "precentage",           :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
