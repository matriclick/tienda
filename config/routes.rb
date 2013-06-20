# encoding: UTF-8
Matri::Application.routes.draw do

  # This is one way to implement the "channel.html" file recommended by facebook. Your application.html.erb should have something like "channelUrl : '//www.matriclick.com/channel.html'"
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

  scope ":country_url_path" do # BEGINING OF SCOPE COUNTRY_URL_PATH
    get "mail_inline/i_want_it/:dress_id" => 'mail_inline#i_want_it', :as => 'mail_inline_i_want_it'
    post "mail_inline/send_i_want_it" => 'mail_inline#send_i_want_it'

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
  
    get 'wedding_planner' => 'wedding_planner_quotes#welcome'
    resources :wedding_planner_quotes
  
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
    
  	get "contests/matridream" => 'contests#matridream', as: 'contests_matridream'
    get "contests/matridream_rules" => 'contests#matridream_rules', as: 'contests_matridream_rules'
    get "contests/add_supplier" => 'contests#add_supplier', as: 'contests_add_supplier'
    get "contests/confirm_selections" => 'contests#confirm_selections', as: 'contests_confirm_selections'

  	#get "travel" => 'contests#travelite', as: 'contests_travelite'
    #get "travel/rules" => 'contests#travelite_rules', as: 'contests_travelite_rules'
    #get "travel/step1" => 'contests#travelite_step1', as: 'contests_travelite_step1'
    #get "travel/step2" => 'contests#travelite_step2', as: 'contests_travelite_step2'
  	#get "travel/select_playeros" => 'contests#select_playeros', as: 'contests_select_playeros'
  	#get "travel/select_viajeros" => 'contests#select_viajeros', as: 'contests_select_viajeros'
  	
  	get "despedida-de-soltera" => 'contests#despedida_de_soltera', as: 'despedida_de_soltera'
  	get "despedida-de-soltera/subir-imagen" => 'contests#subir_imagen', as: 'contests_subir_imagen'
    get "despedida-de-soltera/vote" => "contests#vote", as: 'contests_vote'
    get "despedida-de-soltera/concursante/:slug" => 'contests#travelite_image', as: 'contests_image'      	
    get "se-viene-la-mejor-despedida-de-soltera" => 'contests#preambulo', as: 'contests_preambulo'      	
    get "despedida-de-soltera/bases" => 'contests#bases', as: 'contests_bases'      
    put "despedida-de-soltera/update_image" => 'contests#update_image', as: 'contests_update_image'
    post 'despedida-de-soltera/endless_scrolling' => 'contests#endless_scrolling'
    post '/endless_scrolling' => 'contests#endless_scrolling'

  	get "despedida-de-soltera-final" => 'contests#despedida_de_soltera_final', as: 'despedida_de_soltera_final'
    
    #match "travel/stage1" => 'contests#travelite_stage_1_ending'#, as: 'contests_travelite', :via => [:get, :put]
    #match "travel/stage2" => 'contests#travelite_stage_2_ending'#, as: 'contests_travelite', :via => [:get, :put]
    #match "travel" => 'contests#travelite_final', as: 'contests_travelite', :via => [:get, :put]
    #post 'travelite_stage_1_ending/endless_scrolling' => 'contests#endless_scrolling'    
   	#post "travel/create_travelite_vote" => 'contests#create_travelite_vote', as: 'contests_create_travelite_vote'
  
    get "viajes" => "travel#index", as: 'travel'
    get "viajes/paquetes" => "travel#paquetes", as: 'paquetes'
    get "viajes/destino/:slug" => "travel#destino", as: 'destino'
    get "viajes/caribe" => "travel#caribe", as: 'caribe'    
    get "viajes/sudeste" => "travel#sudeste", as: 'sudeste'
    get "viajes/europa" => "travel#europa", as: 'europa'
            
    get "reports/salestool" => "reports#salestool"
    get "reports/export" => "reports#export"
    get "reports/export_dress_info" => "reports#export_dress_info"
    get "reports/users" => "reports#users"
    get "reports/suppliers" => "reports#suppliers"
    get "reports/activity_details" => "reports#activity_details"
    get "reports/contracts_expiration" => "reports#contracts_expiration"
    get "reports/contracts_details" => "reports#contracts_details"
    get "reports/industry_category_details" => "reports#industry_category_details"
    get "reports/conversations_details" => "reports#conversations_details"
    get "reports/conversations_without_reply" => "reports#conversations_without_reply"
    get "reports/dresses" => "reports#dresses"
    get "reports/dresses_details" => "reports#dresses_details"
    get "reports/contracts" => "reports#contracts"
    get "reports/invoices" => "reports#invoices"
    get "reports/invoices_details" => "reports#invoices_details"
    get "reports/collections" => "reports#collections"
    get "reports/expected_flow" => "reports#expected_flow"
    get "reports/invoices_list" => "reports#invoices_list"
    get "reports/debtor_list" => "reports#debtor_list"
    get "reports/collections_email" => "reports#collections_email"
    get "reports/suppliers_with_contract" => "reports#suppliers_with_contract"
    get "reports/user_conversations" => "reports#user_conversations"
    get "reports/list_user_conversations" => "reports#list_user_conversations"
    get "reports/purchases" => "reports#purchases"
    resources :lead_contacts
    resources :challenge_activities
    resources :challenges
    resources :leads

    get "specials/vina" => 'specials#vina', as: 'specials_vina'
    get "specials/honeymoon" => 'specials#honeymoon', as: 'specials_honeymoon'
  
    resources :matriclickers

    resources :invoices
    get 'invoices/download_file/:attached_file' => 'invoices#download_file', as: 'invoices_download_file'
    resources :contracts
    get 'contracts/download_file/:attached_file' => 'contracts#download_file', as: 'contracts_download_file'
				
    resources :reserved_dates

    put "slider_images/update_positions" => "slider_images#update_positions"
    resources :slider_images
    
    resources :delivery_infos    
    resources :opportunities
    resources :supplier_without_accounts

  	# RATING (STARS)
  	post "rate/:class/:id" => 'application#rate', as: 'rate'
	
  	# CAMPAIGN
    resources :campaign_gallery_items
  	resources :campaign_anecdotes
  	resources :campaign_user_account_infos
  	resources :rocks

    get "campaign/wedding_of_the_year" => "campaign#wedding_of_the_year"
    get "campaign/gallery" => "campaign#gallery"
    get "campaign/d_day" => "campaign#d_day"
    get "campaign/suppliers" => "campaign#suppliers"
    get "campaign/how_to_win" => "campaign#how_to_win"
  	get "campaign/user_story/(:id)" => 'campaign#user_story', as: 'user_story'
  	get "campaign/vote_up/(:id)" => 'campaign#vote_up', as: 'campaign_vote_up'
  	get "campaign/anecdotes/(:id)" => 'campaign#anecdotes', as: 'anecdotes'
    get "campaign/supplier_gallery/(:id)" => 'campaign#supplier_gallery', as: 'supplier_gallery'
    get "campaign/bases" => "campaign#bases"
  	get "campaign/suggested_wedding" => "campaign#suggested_wedding"
  	get "campaign/winners" => "campaign#winners"
  	get "campaign/ending" => "campaign#ending"
  	get "campaign/finalists" => "campaign#finalists"
  	get "campaign/thanks" => "campaign#thanks"
    get "campaign/give_it_away" => "campaign#give_it_away"
    get "campaign/studiosnaps" => "campaign#studiosnaps"
    get "campaign/lasadrianas" => "campaign#lasadrianas"
    get "campaign/rimon" => "campaign#rimon"
    get "campaign/micapricho" => "campaign#micapricho"
    get "campaign/marialuisagarcia" => "campaign#marialuisagarcia"
    get "campaign/noviosparis" => "campaign#noviosparis"
    get "campaign/alejandrasanchez" => "campaign#alejandrasanchez"
  	post "campaign/create_rock" => 'campaign#create_rock', as: 'create_rock'

  	# DRESSES
  	get "dresses/display_dispatch_costs" => 'dresses#display_dispatch_costs', as: 'display_dispatch_costs'
  	
  	get "tramanta" => 'dresses#bazar', as: 'bazar'
  	get 'tramanta/accesorios' => 'dresses#accessories_menu', as: 'dresses_accessories_menu'
  	get "tramanta/vestidos" => 'dresses#party_dress_menu', as: 'dresses_party_dress_menu'
  	get "contacto-tramanta" => 'dresses#contact_elbazar', as: 'contact_elbazar'
  	get "faq-tramanta" => 'dresses#faq_elbazar', as: 'faq_elbazar'
  	
  	get "tu-casa" => 'dresses#tu_casa', as: 'tu_casa'
  	get "tu-casa/living" => 'dresses#tu_casa_living', as: 'tu_casa_living'
  	get "tu-casa/comedor" => 'dresses#tu_casa_comedor', as: 'tu_casa_comedor'
  	get "tu-casa/dormitorio" => 'dresses#tu_casa_dormitorio', as: 'tu_casa_dormitorio'
  	get "tu-casa/decoracion" => 'dresses#tu_casa_decoracion', as: 'tu_casa_decoracion'
  	get "tu-casa/cocina" => 'dresses#tu_casa_cocina', as: 'tu_casa_cocina'
  	get "tu-casa/terraza" => 'dresses#tu_casa_terraza', as: 'tu_casa_terraza'
  	get "tu-casa/bano" => 'dresses#tu_casa_bano', as: 'tu_casa_bano'
  	
  	get 'dresses/set_stock/:id' => 'dresses#set_stock', as: 'dresses_set_stock'
  	post 'dresses/update_stock' => 'dresses#update_stock', as: 'dresses_update_stock'
  	post 'dresses/notify_request/:slug' => 'dresses#notify_request', as: 'dresses_notify_request'
  	get 'dresses/dress_request/:slug' => 'dresses#dress_request', as: 'dresses_dress_request'
  	
  	get "dresses/wedding_dress_menu" => 'dresses#wedding_dress_menu', as: 'dresses_wedding_dress_menu'
  	get "dresses/party_dress_boutique" => 'dresses#party_dress_boutique', as: 'dresses_party_dress_boutique'
  	get "dresses/wedding_dress_stores" => 'dresses#wedding_dress_stores', as: 'dresses_wedding_dress_stores'
  	
  	get "mi-bebe" => 'dresses#baby_clothing_menu', as: 'mibebe_menu'
  	get "dresses/women_clothing_menu" => 'dresses#women_clothing_menu', as: 'dresses_women_clothing_menu'

#  	put "dresses" => 'dresses#index', as: 'dresses'
#   post "dresses/endless_scrolling" => 'dresses#endless_scrolling', as: 'dresses_endless_scrolling'

  	get "dresses/ver/:type" => 'dresses#view', as: 'dresses_ver'
  	post "dresses/ver/dresses/endless_scrolling" => 'dresses#endless_scrolling', as: 'dresses_endless_scrolling'
  	resources :dresses, :except => ['show']
	  get 'dresses/:type/:slug' => 'dresses#show', :as => 'dress_ver'
	  get 'dresses/buscar' => 'dresses#view_search', :as => 'dresses_search'
	  post "dresses/dresses/endless_scrolling" => 'dresses#endless_scrolling'
	  
	  get 'dresses/refund_policy'	=> 'dresses#refund_policy', as: 'refund_policy'
	  resources :refund_requests
    resources :cloth_measures	    
  	resources :mailings
  	# BLOG
    resources :posts do
  		resources :blog_comments  	
    end
    get 'blog' => 'posts#blog'
  
  	# PACKS
    get 'casonas-matriclick' => 'packs#index', as: 'casonas_matriclick'
    get 'lunas-de-miel' => 'packs#honey_moons', as: 'lunas_de_miel'
    get 'blog-viajes' => 'packs#viajes', as: 'blog_viajes'
    get 'blog-tu-casa' => 'packs#tu_casa', as: 'blog_tu_casa'
    get 'blog-bebe' => 'packs#aguclick', as: 'blog_aguclick'
    get 'blog-tramanta' => 'packs#el_bazar', as: 'blog_el_bazar'
    resources :contacts

  	# CEREMONY
  	get "ceremonies" => "ceremonies#menu", as: 'ceremonies_menu'
    get "ceremonies/:ceremony_type_name/places" => 'ceremonies#places', as: 'ceremonies_places'
		resources :tips, :except => ['index', 'create']
  	get 'ceremonies/:ceremony_type_name/tips' => 'tips#index', as: 'tips'
  	post 'tips/create' => 'tips#create', as: 'tips_create'
  	put 'tips/update' => 'tips#update', as: 'tips_update'
  	resources :ceremonies, :except => ['index']
  	get 'ceremonies/index' => 'ceremonies#index', as: 'ceremonies'
  	# CEREMONY TIPS


    # MATRICHECKLIST
  	match "matrichecklist" => 'matrichecklist#index', as: 'matrichecklist_index'
    get "matrichecklist/index" => "matrichecklist#index"
    get "matrichecklist/reminders" => "matrichecklist#reminders"
    get "matrichecklist/activity" => "matrichecklist#activity"
    get "matrichecklist/edit" => "matrichecklist#edit"
    get "matrichecklist/add" => "matrichecklist#add"
    get "matrichecklist/ganttchart" => "matrichecklist#ganttchart"
    get "matrichecklist/done" => "matrichecklist#done"
    post "matrichecklist/create" => "matrichecklist#create"
    post "matrichecklist/reminders" => "matrichecklist#reminders"
    post "matrichecklist/activate_reminder" => "matrichecklist#activate_reminder"
    put "matrichecklist/update" => "matrichecklist#update"
    delete "matrichecklist/delete_reminder" => "matrichecklist#delete_reminder"
    delete "matrichecklist/delete" => "matrichecklist#delete"
    get 'matrichecklist/done' => 'matrichecklist#done'
    get 'matrichecklist/view_activity' => 'matrichecklist#view_activity'
      
    # USER_PROFILE
    get 'user_profile'											=> 'user_profile#purchases',					as: 'user_profile'
    get 'user_profile/personalization'			=> 'user_profile#personalization',		as: 'user_profile_personalization'
    get 'user_profile/estilos'		        	=> 'user_profile#edit_tags',	      	as: 'user_profile_edit_tags'
    put "user_profile/update_tags"          => "user_profile#update_tags",        as: 'user_profile_update_tags'
    
  	# BOOKING
  	match 'bookings'											=> 'bookings#booking_list', 		as: 'bookings_booking_list'
  	match 'bookings/update_booking/:id' 		=> 'bookings#update_booking', 	as: 'bookings_update_booking'
	
  	# BUDGET
  	match 'budget_menu' => 'budgets#menu', as: 'budget_menu'
    get 'budgets/instructions' => 'budgets#instructions', as: 'budget_instructions'
  	get 'budgets/econ' => 'budgets#econ', as: 'econ_budget'
  	get 'budgets/standard' => 'budgets#standard', as: 'standard_budget'
  	get 'budgets/premium' => 'budgets#premium', as: 'premium_budget'
  	get 'budgets/settings' => 'budgets#settings', as: 'budget_settings'
  	put	'budgets/update_budget_config' => 'budgets#update_budget_config', as: 'update_budget_config'
  	resources :budgets

  	# SUPPLIERS CATALOG
  	scope ":public_url" do
  		get "supplier_description" => 'suppliers_catalog#supplier_description', as: 'supplier_description'
  		get "supplier_products_and_services" => 'suppliers_catalog#supplier_products_and_services', as: 'supplier_products_and_services'
  		get "supplier_contacts" => 'suppliers_catalog#supplier_contacts', as: 'supplier_contacts'
  		post 'suppliers_catalog/:supplier_id/ask_reference' => 'reference_requests#ask_reference', as: 'suppliers_catalog_ask_reference'
  		get "supplier_reviews" => 'suppliers_catalog#supplier_reviews', as: 'supplier_reviews'
  		get "supplier_calendar" => 'suppliers_catalog#supplier_calendar', as: 'supplier_calendar'
    end
  
  	# PRODUCTS AND SERVICES CATALOG  	
  	get "products_and_services_catalog/:industry_category_ids" => 'products_and_services_catalog#index', as: 'products_and_services_catalog_index'
  	get "products_and_services_catalog/:industry_category_ids/products_and_services"  => 'products_and_services_catalog#products_and_services', as: 'products_and_services_catalog_all_services'
  	get "products_and_services_catalog/:industry_category_ids/with_or_without_account"  => 'products_and_services_catalog#with_or_without_account', as: 'products_and_services_catalog_all_suppliers'
  	get "products_and_services_catalog/:industry_category_ids/album"  => 'products_and_services_catalog#album', as: 'products_and_services_catalog_album'
  	get "products_and_services_catalog/supplier_without_account_info" => 'products_and_services_catalog#supplier_without_account_info', as: 'supplier_without_account_info'
  	# SELECCIONA LA INDUSTRIA
  	match 'products_and_services_catalog' => 'products_and_services_catalog#select_industry_category', as: 'products_and_services_catalog_select_industry_category'
  	# REVISA UN PRODUCTO O SERVICIO ESPECÍFICO
  	get 'products_and_services_catalog/:slug/description' => 'products_and_services_catalog#description', as: 'products_and_services_catalog_description'
  	get 'products_and_services_catalog/:slug/faqs' => 'products_and_services_catalog#faqs', as: 'products_and_services_catalog_faqs'
  	get 'products_and_services_catalog/:slug/conversations' => 'products_and_services_catalog#conversations', as: 'products_and_services_catalog_conversations'
  	get 'products_and_services_catalog/:slug/contacts' => 'products_and_services_catalog#contacts', as: 'products_and_services_catalog_contacts'
  	post 'products_and_services_catalog/:slug/ask_reference' => 'reference_requests#ask_reference', as: 'products_and_services_catalog_ask_reference_ask_reference'
  	post 'products_and_services_catalog/:slug/add_to_budget/:budget_type_id' => 'products_and_services_catalog#add_to_budget', as: 'products_and_services_catalog_add_to_budget'
    post 'products_and_services_catalog/:slug/endless_scrolling' => 'products_and_services_catalog#endless_scrolling', as: 'products_and_services_catalog_endless_scrolling'
  	get 'products_and_services_catalog/:id/download_file/:attached_file' => 'products_and_services_catalog#download_file', as: 'products_and_services_catalog_download_file'

  	# PRODUCTS AND SERVICES => BOOKINGS
  	get 'products_and_services_catalog/(:object_class)(.:id)/bookings' => 'products_and_services_catalog#bookings', as: 'products_and_services_catalog_bookings'
  	post 'products_and_services_catalog/add_booking' => 'products_and_services_catalog#add_booking', as: 'products_and_services_catalog_add_booking'
  	delete 'products_and_services_catalog/destroy_booking/:id' => 'products_and_services_catalog#destroy_booking', as: 'products_and_services_catalog_destroy_booking'


    #MATRISHEETS
    match '/invitees/upload' => 'matrisheets#upload', as: 'matrisheet_upload'
  	match '/invitees/download' => 'matrisheets#download', as: 'matrisheet_download'
  	match '/invitees/base_file' => 'matrisheets#send_base_file', as: 'matrisheet_send_base_file'	

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
  			# CONVERSATIONS
  			get 'conversations' => 'conversations#index', as: 'conversations'
  			get 'conversations/download_file/:attached_file' => 'conversations#download_file', as: 'conversations_download_file'
  			# ALBUMS
      	resources :albums
  			# DRESSES
      	resources :dresses, :except => ['index']
      	get "dresses" => 'dresses#supplier_view', as: 'dresses'
      	match "dresses/ver/dresses/endless_scrolling" => 'dresses#endless_scrolling', as: 'dresses_endless_scrolling'
        get 'dresses/set_stock/:id' => 'dresses#set_stock', as: 'dresses_set_stock'
      	post 'dresses/update_stock' => 'dresses#update_stock', as: 'dresses_update_stock'
  	  	post "dresses/endless_scrolling" => 'dresses#endless_scrolling'
  			# GIFT CARDS
        resources :gift_cards
  			# STATISTICS
  			get 'statistics' => 'statistics#index', as: 'statistics'
  			# NO MORE BOOKINGS
  			get 'calendar'  => 'supplier_accounts#calendar', as: 'calendar'
  		  get 'reserve_date'  => 'supplier_accounts#reserve_date', as: 'reserve_date'
  			resources :supplier_contacts
  			resources :products	do
  				match '/update_multiple' => 'product_images#update_multiple', as: '/update_multiple'
  				resources :product_images do
  					member do
  						put "set_image_index" => 'product_images#set_image_index', as: 'set_image_index'
  						put "toggle_active" => 'product_images#toggle_active', as: 'toggle_active'
  					end
  				end
				
  			end
  			resource :presentation do
  				resources :presentation_images
  			end
  			resources :services do
  				match '/update_multiple' => 'service_images#update_multiple', as: '/update_multiple'
  	      resources :service_images do
  					member do
  						put "set_image_index" => 'service_images#set_image_index', as: 'set_image_index'
  						put "toggle_active" => 'service_images#toggle_active', as: 'toggle_active'
  					end
  				end
  			  resources :schedules
  	    end
  		end
  	end
    resources :product_types, :industry_categories, :contact_types, :users, :feedbacks, :invitee_groups, :invitations
	
  
  	match 'invitees_menu' => 'invitees#menu', as: 'invitees_menu'	
  	resources :invitees do							
  		collection do			
  			get 'statistics' => 'invitees#statistics', as: 'statistics'			
  		end
  	end
	

  	# EXPENSES
  	get 'points' => 'expenses#points', as: 'points'
  	get 'expenses/filter_supplier_accounts' => 'expenses#filter_supplier_accounts'	
  	resources :expenses do
  		collection do
  			get 'statistics' => 'expenses#statistics', as: 'statistics'
  		end
  	end


  	resources :conversations
  	#Messages inside conversations
  	post 'conversations/create_message' => 'conversations#create_message', as: 'conversations_create_message'
  	#post 'conversations/create_by_service' => 'conversations#create_by_service', as: 'conversations_create_by_service'
  	# USER CONVERSATIONS
  	match "user_conversations"=>'user_conversations#index', as:'user_conversations_index'
	
	
  	# REVIEWS
  	get 'reviews/index' => 'reviews#index', as: 'reviews_index'
  	post 'reviews/create' => 'reviews#create', as: 'reviews_create'
	
  	# FGM Routes for the home controller (non-RESTful)
		match '/welcome' => "home#index"
		get '/terms' => "home#terms"
		get '/company' => "home#company"
		get '/faq' => "home#faq"
		get '/criteria' => "home#criteria"
		get '/como_nace' => "home#como_nace"
		get '/press' => "home#press"
		get '/work_with_us' => "home#work_with_us"
		get '/tour' => "home#tour"
		get '/wedding_tools' => "home#wedding_tools"
		get '/marry_me' => "home#marry_me"
		get '/test-home' => "home#test_home"
		get '/suscribirse' => 'home#subscription', as: 'subscription'
		post '/subscription_create' => 'home#subscription_create',	 as: 'subscription_create'	

  	match '/supplier/main' => "supplier_accounts#show", as: :supplier_home
	
  	scope ':public_url' do #DZF this alows to search a supplier without crashing with resources in the "/ "
  		root :to => "suppliers_catalog#supplier_description"
  	end

    # ADMINISTRATION
    get "administration/index" => "administration#index"
    get "administration" => "administration#index"
    get "administration/webpage_contacts" => 'administration#webpage_contacts', as: 'administration_webpage_contacts'  
    get "administration/old_dresses" => 'administration#old_dresses', as: 'administration_old_dresses'
    get "administration/dresses" => 'administration#dresses', as: 'administration_dresses'
    get "administration/dress" => 'administration#dress', as: 'administration_dress'
    get "administration/dresses_list" => 'administration#dresses_list', as: 'administration_dresses_list'
    get "administration/view_old_dress" => "administration#view_old_dress"
    get "administration/suppliers_list" => "administration#suppliers_list"
    get "administration/show_supplier_account/:id" => 'administration#show_supplier_account', as: 'administration_show_supplier_account'
    get "administration/show_supplier_products/:id" => 'administration#show_supplier_products', as: 'administration_show_supplier_products'
    get "administration/show_supplier_services/:id" => 'administration#show_supplier_services', as: 'administration_show_supplier_services'
    get "administration/edit_supplier_account/:supplier_account_id" => 'administration#edit_supplier_account', as: 'administration_edit_supplier_account'
    get "administration/reset_supplier_password/:supplier_account_id" => 'administration#reset_supplier_password', as: 'administration_reset_supplier_password'
    get "administration/edit_supplier_product/:product_id" => 'administration#edit_supplier_product', as: 'administration_edit_supplier_product'
    get "administration/edit_supplier_service/:service_id" => 'administration#edit_supplier_service', as: 'administration_edit_supplier_service'
    get "administration/edit_dispatch_costs" => 'administration#edit_dispatch_costs', as: 'administration_edit_dispatch_costs'
    put "administration/update_dispatch_costs" => 'administration#update_dispatch_costs', as: 'administration_update_dispatch_costs'
    put "administration/update_supplier_account/:id" => 'administration#update_supplier_account', as: 'administration_update_supplier_account'
    put "administration/update_supplier_product/:id" => 'administration#update_supplier_product', as: 'administration_update_supplier_product'
    put "administration/update_supplier_service/:id" => 'administration#update_supplier_service', as: 'administration_update_supplier_service'
    delete "administration/destroy_old_dress/:id" => 'administration#destroy_old_dress', as: 'administration_destroy_old_dress'
    delete "administration/destroy_supplier/:id" => 'administration#destroy_supplier', as: 'administration_destroy_supplier'
    delete "administration/destroy_supplier_product/:id" => 'administration#destroy_supplier_product', as: 'administration_destroy_supplier_product'
    delete "administration/destroy_supplier_service/:id" => 'administration#destroy_supplier_service', as: 'administration_destroy_supplier_service'

    # ADMINISTRATION REVIEWS
    get	"administration/reviews" => "administration#reviews"
    get "administration/new_review/:id" => "administration#new_review", as: "administration_new_review"
    get "administration/edit_review/:id" => "administration#edit_review", as: "administration_edit_review"
    put "administration/update_review/:id" => "administration#update_review", as: "administration_update_review"
    delete "administration/destroy_review/:id" => "administration#destroy_review", as: "administration_destroy_review"
    
    # ADMINISTRATION PACK PROMOTIONS
    scope 'administration' do
      resources :pack_promotions do 
        collection do 
          put 'update_multiple'
        end 
      end
  	end
  	
  	get "administration/mailing-tools" => "administration#mailing_tools", as: 'administration_mailing_tools'
  	get "administration/mailing_sent" => "administration#mailing_sent", as: 'administration_mailing_sent'
    	      
  end # ENDING OF SCOPE COUNTRY_URL_PATH
  
  match ':country_url_path' => 'dresses#bazar', as: :root_country
  root :to => "dresses#bazar"

  #SEO: Realiza match con archivo routes.yml para cambio de nombre (alias) a la ruta - HAY QUE DEJARLO AL FINAL
  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml')
  
end
