# encoding: UTF-8
Matri::Application.routes.draw do

  resources :home_categories

  resources :dress_stock_change_notifications

  resources :wbr_data
  resources :contests
  resources :contestants
  resources :posts
  get 'blog' => 'posts#blog', as: 'blog_el_bazar'
  
  put "contestants/add_vote/:id"     => "contestants#add_vote",   as: 'contestants_add_vote'
  
  get "seleccionar-tienda" => 'store_admin#select_store', :as => 'store_admin_select_store'
  get "productos-tienda/:public_url" => 'store_admin#products', :as => 'store_admin_products'
  get "ventas-tienda/:public_url" => 'store_admin#purchases', :as => 'store_admin_purchases'
  get "pagos-tienda/:public_url" => 'store_admin#payments', :as => 'store_admin_payments'
  get "usuarios-tienda/:public_url" => 'store_admin#users', :as => 'store_admin_users'
  get "reportes-tienda/:public_url" => 'store_admin#reports', :as => 'store_admin_reports'
  get "punto-de-venta/:public_url" => 'store_admin#point_of_sale', :as => 'store_admin_point_of_sale'
  get "usuarios-tienda/:public_url/:user_id" => 'store_admin#select_user_privileges', :as => 'store_admin_select_user_privileges'
  get "reportes/:public_url/transacciones" => 'store_admin#reports_transactions', :as => 'store_admin_reports_transactions'
  get 'dresses/barcode/:slug'	=> 'store_admin#barcode', as: 'store_admin_barcode'
  get 'reportes/:public_url/ventas'	=> 'store_admin#reports_sales', as: 'store_admin_reports_sales'
  get 'reportes/:public_url/inventario'	=> 'store_admin#reports_inventory', as: 'store_admin_reports_inventory'

  put "usuarios-tienda/:public_url/agregar-usuario" => 'store_admin#add_user', :as => 'store_admin_add_user'  
  put "update-store-admin-privileges/:public_url/:user_id" => 'store_admin#update_store_admin_privileges', :as => 'store_admin_update_store_admin_privileges'
  post "add-product-to-cart-from-barcode/:public_url" => 'store_admin#add_product_to_cart_from_barcode', :as => 'store_admin_add_product_to_cart_from_barcode'
  put "remove-product-from-cart/:public_url/:cart_id/:product_id" => 'store_admin#remove_product_from_cart', :as => 'store_admin_remove_product_from_cart'
  put "generate-pos-purchase/:public_url/:cart_id" => 'store_admin#generate_pos_purchase', :as => 'store_admin_generate_pos_purchase'
  put "usuarios-tienda/:public_url/:user_id/remover" => 'store_admin#remove_user', :as => 'store_admin_remove_user'
  
  
  post 'buy/add_to_cart' => 'buy#add_to_cart'
  post 'buy/remove_from_cart' => 'buy#remove_from_cart'
  post 'buy/success_transfer' => 'buy#success_transfer'
  post 'buy/success_full_credit' => 'buy#success_full_credit'

  match 'buy/index' => 'buy#index', :via => [:get, :post]
  match 'buy/notify' => 'buy#notify', :via => [:get, :post]
  match 'buy/success' => 'buy#success', :via => [:get, :post]
  match 'buy/failure' => 'buy#failure', :via => [:get, :post]
  
  match 'buy/confirm' => 'buy#confirm', :via => [:get, :post]
  match 'buy/details' => 'buy#details', :via => [:get, :post]
  match 'buy/view_cart' => 'buy#view_cart', :via => [:get, :post]
  put 'buy/refresh_cart' => 'buy#refresh_cart'

  match 'notify' => 'buy#notify', :via => [:get, :post]
  match 'success' => 'buy#success', :via => [:get, :post]
  match 'failure' => 'buy#failure', :via => [:get, :post]
  
  resources :sizes do 
    collection do 
      put 'update_multiple'
    end 
  end

  resources :delivery_infos

  get 'purchases/show_for_user/:id' => 'purchases#show_for_user', as: 'purchases_show_for_user'
  get 'purchases/refund_credit' => 'purchases#refund_credit'
  post 'purchases/generate_refund_credit' => 'purchases#generate_refund_credit'
  resources :purchases

  get "gift_cards/gift_card_codes" => 'gift_cards#gift_card_codes', as: 'gift_cards_gift_card_codes'
  get "gift_cards/mark_used_code" => 'gift_cards#mark_used_code', as: 'gift_cards_mark_used_code'
  get "gift_cards/mark_bought_code" => 'gift_cards#mark_bought_code', as: 'gift_cards_mark_bought_code'
  get "gift_cards/add_dresses" => 'gift_cards#add_dresses', as: 'gift_cards_add_dresses'
  get "gift_cards/view_coupon" => 'gift_cards#view_coupon', as: 'gift_cards_view_coupon'
  get "gift_cards/show_coupon/:id" => 'gift_cards#show_coupon', as: 'gift_cards_show_coupon'
  post "gift_cards/update_dresses" => 'gift_cards#update_dresses', as: 'gift_cards_update_dresses'
  resources :gift_cards
  
  get "reports/users" => "reports#users"
  get "reports/purchases" => "reports#purchases"
  get 'reports/sales_dashboard' => 'reports#sales_dashboard', as: 'reports_sales_dashboard'
  get 'reports/products_payments' => 'reports#products_payments', as: 'reports_products_payments'
  get 'reports/sales_by_category' => 'reports#sales_by_category', as: 'reports_sales_by_category'
  get 'reports/sales_by_store' => 'reports#sales_by_store', as: 'reports_sales_by_store'
  get 'reports/products_in_wish_list' => 'reports#products_in_wish_list', as: 'reports_products_in_wish_list'
  get 'reports/store_payments' => 'reports#store_payments', as: 'reports_store_payments'
  get 'reports/purchases_to_be_delivered' => 'reports#purchases_to_be_delivered', as: 'reports_purchases_to_be_delivered'
  get 'reports/products_detail_excel' => 'reports#products_detail_excel', as: 'reports_products_detail_excel'
  get 'reports/credits' => 'reports#credits', as: 'reports_credits'
  get 'reports/wbr' => 'reports#wbr', as: 'reports_wbr'
  get 'reports/products_to_be_delivered_by_store' => 'reports#products_to_be_delivered_by_store', as: 'reports_products_to_be_delivered_by_store'
  resources :matriclickers
  
  # DRESSES
	get "dresses/display_dispatch_costs" => 'dresses#display_dispatch_costs', as: 'display_dispatch_costs'
	
	get "contacto-tramanta" => 'dresses#contact_elbazar', as: 'contact_elbazar'
	get "faq-tramanta" => 'dresses#faq_elbazar', as: 'faq_elbazar'	
	get 'dresses/set_stock/:id' => 'dresses#set_stock', as: 'dresses_set_stock'
	post 'dresses/update_stock' => 'dresses#update_stock', as: 'dresses_update_stock'
	get "dresses/ver/:type" => 'dresses#view', as: 'dresses_ver'
	resources :dresses, :except => ['show']
  get 'dresses/:type/:slug' => 'dresses#show', :as => 'dress_ver'
  get 'dresses/buscar' => 'dresses#view_search', :as => 'dresses_search'
  post "dresses/dresses/endless_scrolling" => 'dresses#endless_scrolling'
  get 'dresses/new-arrivals'	=> 'dresses#new_arrivals', as: 'dresses_new_arrivals'
  get 'dresses/clearing'	=> 'dresses#clearing', as: 'dresses_clearing'  
  get 'dresses/refund_policy'	=> 'dresses#refund_policy', as: 'refund_policy'
  resources :refund_requests
  resources :cloth_measures
	resources :mailings
  resources :contacts
    
  # USER_PROFILE
  get 'user_profile'											=> 'user_profile#purchases',					as: 'user_profile'
  get 'user_profile/personalization'			=> 'user_profile#personalization',		as: 'user_profile_personalization'
  get 'user_profile/estilos'		        	=> 'user_profile#edit_tags',	      	as: 'user_profile_edit_tags'
  put "user_profile/update_tags"          => "user_profile#update_tags",        as: 'user_profile_update_tags'
  get 'user_profile/wish_list'		       	=> 'user_profile#wish_list',	      	as: 'user_profile_wish_list'
  put "user_profile/add_to_wish_list"     => "user_profile#add_to_wish_list",   as: 'user_profile_add_to_wish_list'
  get 'user_profile/information'		     	=> 'user_profile#information',	     	as: 'user_profile_information'
  get 'user_profile/contests'		     	    => 'user_profile#contests',	         	as: 'user_profile_contests'
  
	# SUPPLIERS CATALOG
	scope ":public_url" do
		get "supplier_description" => 'suppliers_catalog#supplier_description', as: 'supplier_description'
		get "supplier_products_and_services" => 'suppliers_catalog#supplier_products_and_services', as: 'supplier_products_and_services'
		get "supplier_contacts" => 'suppliers_catalog#supplier_contacts', as: 'supplier_contacts'
		post 'suppliers_catalog/:supplier_id/ask_reference' => 'reference_requests#ask_reference', as: 'suppliers_catalog_ask_reference'
		get "supplier_reviews" => 'suppliers_catalog#supplier_reviews', as: 'supplier_reviews'
		get "supplier_calendar" => 'suppliers_catalog#supplier_calendar', as: 'supplier_calendar'
  end
  
  devise_for :suppliers

	devise_scope :supplier do
		match '/supplier_login' => "devise/sessions#new"
	end

	devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks', :registrations => 'users/registrations' }

  devise_scope :user do
    match '/user_sign_up' => "devise/registrations#new"
  end

	resources :suppliers do
		resource :supplier_account, as: :account do
			# DRESSES
    	resources :dresses, :except => ['index']
    	get "dresses" => 'dresses#supplier_view', as: 'dresses'
      get 'dresses/set_stock/:id' => 'dresses#set_stock', as: 'dresses_set_stock'
    	post 'dresses/update_stock' => 'dresses#update_stock', as: 'dresses_update_stock'
			resources :supplier_contacts
			resource :presentation do
				resources :presentation_images
			end
		end
	end
  resources :industry_categories, :users

	# FGM Routes for the home controller (non-RESTful)
	match '/welcome' => "home#index"
	get '/terms' => "home#terms"
	get '/company' => "home#company"
	get '/faq' => "home#faq"
	get '/criteria' => "home#criteria"
	get '/como_nace' => "home#como_nace"
	get '/press' => "home#press"
	get '/work_with_us' => "home#work_with_us"
	get '/wedding_tools' => "home#wedding_tools"
	get '/suscribirse' => 'home#subscription', as: 'subscription'
	get '/como-funciona-tramanta' => 'home#tour', as: 'home_tour'
	post '/subscription_create' => 'home#subscription_create',	 as: 'subscription_create'	

  # ADMINISTRATION
  get "administration" => "administration#index", as: 'administration_index'
  get "administration/webpage_contacts" => 'administration#webpage_contacts', as: 'administration_webpage_contacts'  
  get "administration/suppliers_list" => "administration#suppliers_list"
  get "administration/edit_supplier_account/:supplier_account_id" => 'administration#edit_supplier_account', as: 'administration_edit_supplier_account'
  get "administration/reset_supplier_password/:supplier_account_id" => 'administration#reset_supplier_password', as: 'administration_reset_supplier_password'
  get "administration/edit_dispatch_costs" => 'administration#edit_dispatch_costs', as: 'administration_edit_dispatch_costs'
  put "administration/update_dispatch_costs" => 'administration#update_dispatch_costs', as: 'administration_update_dispatch_costs'
  put "administration/update_supplier_account/:id" => 'administration#update_supplier_account', as: 'administration_update_supplier_account'
  delete "administration/destroy_supplier/:id" => 'administration#destroy_supplier', as: 'administration_destroy_supplier'
	get "administration/mailing-tools" => "administration#mailing_tools", as: 'administration_mailing_tools'
	get "administration/mailing_sent" => "administration#mailing_sent", as: 'administration_mailing_sent'
  get 'administration/edit_purchase/:id' => "administration#edit_purchase", as: 'administration_edit_purchase'
  put 'administration/update_purchase/:id' => "administration#update_purchase", as: 'administration_update_purchase'
  get 'administration/autocomplete_user_email' => 'administration#autocomplete_user_email'
  get "administration/store_admin" => "administration#store_admin", as: 'administration_store_admin'
  get "administration/add_user_to_supplier/:sa_id" => "administration#add_user_to_supplier", as: 'administration_add_user_to_supplier'
  put "administration/assign_user_to_supplier" => "administration#assign_user_to_supplier", as: 'administration_assign_user_to_supplier'

  post "administration/new_store_payment" => "administration#new_store_payment", as: 'administration_new_store_payment'
  put "administration/create_store_payment" => "administration#create_store_payment", as: 'administration_create_store_payment'
  
  get "administration/configuration" => "administration#configuration", as: 'administration_configuration'
  put "administration/save_configuration" => "administration#save_configuration", as: 'administration_save_configuration'
  
  match '/supplier/main' => "supplier_accounts#show", as: :supplier_home	
  
  scope ':public_url' do #DZF this alows to search a supplier without crashing with resources in the "/ "
		root :to => "suppliers_catalog#supplier_description"
	end
  
  get "/" => "dresses#bazar", as: 'bazar'
  
  root :to => "dresses#bazar"
  
  #SEO: Realiza match con archivo routes.yml para cambio de nombre (alias) a la ruta - HAY QUE DEJARLO AL FINAL
  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml')

  # This is one way to implement the "channel.html" file recommended by facebook. Your application.html.erb should have something like "channelUrl : '//www.tramanta.com/channel.html'"
  get '/channel.html' => proc {
    [
      200,
      {
        'Pragma'        => 'public',
        'Cache-Control' => "max-age=#{1.year.to_i}",
        'Expires'       => 1.year.from_now.to_s(:rfc822),
        'Content-Type'  => 'text/html'
      },
      ['<script type="text/javascript" src="//connect.facebook.net/en_US/all.js"></script>']
    ]
  }  
end
