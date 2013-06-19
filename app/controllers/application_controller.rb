# encoding: UTF-8
class ApplicationController < ActionController::Base  
  before_filter :set_user_language, :meta_content_default, :set_time_zone, :set_country, :save_matriclick_last_url_in_session, :set_locale_from_url, :subscriber_pop_up
  before_filter :set_type_param
	protect_from_forgery

	rescue_from CanCan::AccessDenied do |exception|
	  redirect_to root_country_url, :alert => exception.message
  end

	def meta_content_default
    	@title_content = "Tramanta.com"
    	@meta_description_content = "Compra online vestidos de fiesta, chaquetas, blusas, y muchas otros productos de moda en Tramanta.com"
      @og_type = 'article'
      @og_image = 'http://www.tramanta.com/assets/el_bazar/logo-bf68209fb8b99b402a5a903d59550732.png'
      @og_description = 'Tramanta.com'
    	#SEO: indica el idioma natural en el que el sitio será mostrado, en ocasiones es utilizado
    	#     por los buscadores para indexar.
    	@meta_languaje_content = "es"

    	#SEO: A pesar de que ya no tienen la misma importancia que antes, no esta demas agregar explicitamente
    	#     keywords en los tags meta (se puede sobreescribir por cada controlador al igual que las demas
      # 	  variables declaradas en meta_content_default)
    	@meta_keywords_content = "vestidos de fiesta, blusas, chaquetas, poleras, poleranos, aros, collares, pantalones, leggings"   	
  end
  	
	def subscriber_pop_up 
	  if detect_browser != 'mobile'	    
  	  if session[:url_coming_from].nil?
  	    session[:url_coming_from] = request.fullpath
  	  end
	  
  	  if !cookies[:asked_to_subscribe]
    	  @subscriber_pop_up = '$("a.subscription_popup").trigger("click");'
  	    cookies[:asked_to_subscribe] = { :value => true, :expires => 2.month.from_now }
      end
    end
  end
	
	def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :country_url_path => params[:country_url_path].blank? ? 'chile' : params[:country_url_path] }
  end
  
  def find_product_or_service(slug)
    find_by_id = numeric? slug
    
    if find_by_id
      ser = Service.find(slug)
    else
      ser = Service.find_by_slug(slug)
    end
    
    if ser.nil?
      if find_by_id
        prod = Product.find(slug)
      else
        prod = Product.find_by_slug(slug)
      end
      return prod
    else
      return ser
    end
  end
    
	# FGM: rate any object (rateable). Only one vote per object per user.
	# Only one vote per object per cookie stored.
	def rate
		@object = eval("#{params[:class]}.find(#{params[:id]})")
		@star_value = params[:star_value]
		@user = User.find params[:user_id] if params[:user_id]
		
		# FGM: If there's a user, check if voted object exists.
		if @user.present?
			if @object.voted_by_user?(@user)
				@star_rating = @object.star_ratings.where(user_id: @user.id).first
				@star_rating.update_attribute(:value, params[:star_value])
			else
				@object.star_ratings << StarRating.new(value: @star_value, user_id: @user.id)
			end		
			
		# FGM: If no user, store vote in cookies.
		# ALERT: Cookies can't store hashes, so a string is being stored for later parsing and evaluation.
		else
			if cookies[:rated].blank?
				
				# FGM: Storing cookie as "object_id@object_class"
				cookies[:rated] = "#{@object.id}@#{@object.class}"
				@object.star_ratings << StarRating.new(value: @star_value)
			else
				# FGM: Convert string to hash (i.e. "uu@p, xx@m, yy@n, zz@m" will output {"m" => ["xx", "zz"], "n" => ["yy"], "p" => ["uu"]})
				cookies[:rated].to_s.split(/,/).inject(Hash.new{ |h,k| h[k]=[] }) do |h,s|
					v,k = s.split(/@/)
					h[k] << v
					@hashed_cookie = h
				end
				unless @hashed_cookie[@object.class.to_s].include? @object.id.to_s
					cookies[:rated] += ",#{@object.id}@#{@object.class}"
					@object.star_ratings << StarRating.new(value: @star_value)
				end
			end
		end
		
		respond_to do |format|
			format.js
		end
	end
  
	# FGM: Permute ProductImage pair :image_indexes
	def set_image_index

		# FGM: Could have been "DRYer"...
		if params[:product_id]
		  @product = Product.find params[:product_id]
			@product_image = ProductImage.find params[:id]
	    @the_other_product_image = ProductImage.where(:product_id => @product.id, :image_index => params[:image_index]).first

	    # FGM: image_index exchange
	    # FGM: WARNING: update_attribute skips validation (:set_image_index_depending_on_active) intentionally.
	    if !@the_other_product_image.nil?
	      @the_other_product_image.update_attribute(:image_index, @product_image.image_index)
      end
	    @product_image.update_attribute :image_index, params[:image_index]
		elsif params[:service_id] and params[:room_id].blank?
			@service = Service.find params[:service_id]
			@service_image = ServiceImage.find params[:id]

	    @the_other_service_image = ServiceImage.where(:service_id => @service.id, :image_index => params[:image_index]).first
	    
	    # FGM: image_index exchange
	    # FGM: WARNING: update_attribute skips validation (:set_image_index_depending_on_active) intentionally.
	    if !@the_other_service_image.nil?
	      @the_other_service_image.update_attribute(:image_index, @service_image.image_index)
      end
	    @service_image.update_attribute :image_index, params[:image_index]
	    
		elsif params[:room_id]
			@room = Room.find params[:room_id]
			@room_image = RoomImage.find params[:id]
	    @the_other_room_image = RoomImage.where(:room_id => @room.id, :image_index => params[:image_index]).first

	    # FGM: image_index exchange
	    # FGM: WARNING: update_attribute skips validation (:set_image_index_depending_on_active) intentionally.
	    @the_other_room_image.update_attribute :image_index, @room_image.image_index
	    @room_image.update_attribute :image_index, params[:image_index]
		end
		
		respond_to do |format|
			format.html { redirect_to :back }
			format.js { render "load_images_for_edit" }
		end
	end
	
  # FGM: Update :active attribute.
  # FGM: Update Images with greater image_index when a given Image is deactivated.
	def toggle_active
		# FGM: Could have been "DRYer"...
		if params[:product_id]
			@product = Product.find params[:product_id]
			@product_image = ProductImage.find params[:id]
			if @product_image.active
			  @later_product_images = ProductImage.where("image_index > #{@product_image.image_index}").all
	      @later_product_images.each { |pi| pi.update_attribute :image_index, pi.image_index - 1  }
	      @product_image.update_attributes :active => false
	    else 
	      @product_image.update_attributes :active => true
	    end
		elsif params[:service_id] and params[:room_id].blank?
			@service = Service.find params[:service_id]
			@service_image = ServiceImage.find params[:id]
			if @service_image.active
			  @later_service_images = ServiceImage.where("image_index > #{@service_image.image_index}").all
	      @later_service_images.each { |pi| pi.update_attribute :image_index, pi.image_index - 1  }
	      @service_image.update_attributes :active => false
	    else 
	      @service_image.update_attributes :active => true
	    end
		elsif params[:room_id]
			@room = Room.find params[:room_id]
			@room_image = RoomImage.find params[:id]
			if @room_image.active
			  @later_room_images = RoomImage.where("image_index > #{@room_image.image_index}").all
	      @later_room_images.each { |ri| ri.update_attribute :image_index, ri.image_index - 1  }
	      @room_image.update_attributes :active => false
	    else 
	      @room_image.update_attributes :active => true
	    end
		end
		
		respond_to do |format|
			format.html { redirect_to :back }
			format.js {render "load_images_for_edit"}
		end
	end
	
	private
	
	def set_top_menu
    case controller_name
      when 'user_profile', 'contests', 'posts', 'products_and_services_catalog', 'campaign', 'wedding_planner_quotes', 'opportunities', 'ceremonies'
        session[:matriclick_top_menu] = 'Novios'
      when 'administration'
        session[:matriclick_top_menu] = ''
      when 'user_conversations'
        if session[:matriclick_top_menu].blank?
          session[:matriclick_top_menu] = 'Novios'
        end
      when 'packs'
              case action_name
                when 'index', 'honey_moons'
                  session[:matriclick_top_menu] = 'Novios'
                when 'el_bazar'
                  session[:matriclick_top_menu] = 'El Bazar'
                when 'viajes'
                  session[:matriclick_top_menu] = 'Viajes'
                when 'aguclick'
                  session[:matriclick_top_menu] = 'Bebe'
                when 'tu_casa'
                  session[:matriclick_top_menu] = 'Tu Casa'
              end
      when 'home'
              case action_name
                when 'wedding_tools'
                  session[:matriclick_top_menu] = 'Novios'
                else
                  session[:matriclick_top_menu] = ''
              end
      when 'travel'
                  session[:matriclick_top_menu] = 'Viajes'
      when 'dresses'
              case action_name
                when 'bazar', 'party_dress_menu', 'party_dress_boutique', 'accessories_menu', 'contact_elbazar', 'faq_elbazar', 'womens_clothing_menu'
                  session[:matriclick_top_menu] = 'El Bazar'
                when 'baby_clothing_menu'
                  session[:matriclick_top_menu] = 'Bebe'
                when 'wedding_dress_menu', 'wedding_dress_stores'
                  session[:matriclick_top_menu] = 'Novios'
                when 'tu_casa'
                  session[:matriclick_top_menu] = 'Tu Casa'
                when 'index', 'view'
                        case params[:type]
                          when /bebe/
                            session[:matriclick_top_menu] = 'Bebe'
                          when /tu-casa/
                            session[:matriclick_top_menu] = 'Tu Casa'
                          when 'vestidos-novia', 'vestidos-civil', nil
                            session[:matriclick_top_menu] = 'Novios'
                          else
                            session[:matriclick_top_menu] = 'El Bazar'
                        end
                when 'show'
                    if params[:id] != 'endless_scrolling'
                        case params[:type]
                          when /bebe/
                            session[:matriclick_top_menu] = 'Bebe'
                          when /tu-casa/
                            session[:matriclick_top_menu] = 'Tu Casa'
                          when 'vestidos-novia', 'vestidos-civil'
                            session[:matriclick_top_menu] = 'Novios'
                          else
                            session[:matriclick_top_menu] = 'El Bazar'
                        end
                    end
              end
    end
    
    if session[:matriclick_top_menu].nil?
      session[:matriclick_top_menu] = 'Novios'
    end
  end
    	
	def save_matriclick_last_url_in_session
	  if !(controller_name.include?('devise') or controller_name.include?('omniauth_callbacks') or controller_name.include?('registrations') or ['sessions', 'registrations'].include?(controller_name))
	    if !request.url.include?('endless_scrolling') and request.get?
	      session[:matriclick_last_url] = request.url
      end
    end
  end
  
	def set_country
	  default_country = Country.where(:url_path => 'chile').first
	  
    if controller_name.include?('omniauth_callbacks')
      params[:country_url_path] = default_country.url_path
    end
    
	  if !params[:country_url_path]
	    params[:country_url_path] = default_country.url_path
	    redirect_to root_country_path
    else
  	  if Country.where(:url_path => params[:country_url_path]).first.blank?
  	    params[:country_url_path] = default_country.url_path
  	    redirect_to root_country_path
      end
    end
    
  	session[:country] = Country.where(:url_path => params[:country_url_path]).first
  	
    case session[:country].url_path
      when 'peru'
    	  I18n.locale = :esPE
      else
    	  I18n.locale = I18n.default_locale
    end
  end
  
	def set_time_zone
    Time.zone = "Santiago"
  end
	
	def set_supplier_layout
		@supplier_layout = true
	end
	
	def load_user_tools_menu
		@show_user_tools = true
	end

	def check_supplier
    if !admin?
      authenticate_supplier!
    end
	end

	def find_supplier
	  if admin?
      @supplier = Supplier.find_or_create_by_id(params[:supplier_id])
    else
      @supplier = current_supplier
    end
    redirect_if_supplier_account_invalid(@supplier)
	end
	
	def new_feedback
	  @feedback = Feedback.new
  end
  
  def load_reference
  	@reference_request = ReferenceRequest.new
 	end
	
	def redirect_if_supplier_account_invalid(supplier)
		if supplier.supplier_account.blank?
			supplier.ensure_supplier_account_exists
		end
		# FGM: Validation for rut was disabled... for the moment
		# if supplier.supplier_account.rut.blank?
		# 			# FGM: Redirection occurs unless user wants to update his data.
		# 			redirect_to edit_supplier_account_url(supplier) unless (params[:controller] == "supplier_accounts" and (params[:action] == "edit" or params[:action] == "update"))
		# 		end
	end
	
	def after_sign_in_path_for(resource)
		# FGM: Control that only a User or Supplier is logged in...
  		if resource.kind_of? User
  			sign_out(:supplier)
  			if !!session[:matriclick_last_url]
  				session[:matriclick_last_url]
  			else
  				products_and_services_catalog_select_industry_category_path
  			end
  		elsif resource.kind_of? Supplier
  			sign_out(:user)
  			supplier_home_path
  		else
  			root_country_path
  		end
	end
	
	def current_ability
		if user_signed_in?
			@current_ability ||= Ability.new(current_user)
		elsif supplier_signed_in?
			@current_ability ||= Ability.new(current_supplier)
		end
	end
	
  # This sets the default language for a single session
  def set_user_language
    I18n.locale = current_user.language if user_signed_in?
  end

  # DZF: This redirects to the preview page when session[:preview] is true
  def redirect_if_preview_exists
	  if (user_signed_in? and !current_user.nil? and (current_user.role_id == 1))
		  @supplier = Supplier.find(params[:supplier_id])
		else  
		  @supplier = current_supplier
		end
    if session[:preview]
      redirect_to products_catalog_supplier_description_url(@supplier, :preview => true )
    end
  end
  
	def load_budget_types
		@budget_types = BudgetType.all
  end
  
  def load_user_account
  	if user_signed_in?
	  	@user_account = current_user.user_account unless session[:preview] == true
	  end
  end

	def hide_left_menu
	   @hide_left_menu = true
  end

	def redirect_unless_user_signed_in #This works as before_filter :authenticate_user!
		unless user_signed_in? 
			redirect_to root_country_path	
		end
	end
	
	def redirect_to_facebook_login_unless_user_signed_in
		unless user_signed_in? 
			redirect_to omniauth_authorize_path('user', 'facebook')	
		end
	end
	
	def count_unread_conversations
		if user_signed_in?
			@user_conversations_unread_count = 0
			unless current_user.blank?
				unless current_user.conversations.blank?
					@user_conversations_unread_count = current_user.conversations.joins(:messages).where("messages.user_read = 0 or messages.user_read is null").count
				end				
			end
		elsif supplier_signed_in?
			@supplier_conversations_unread_count = 0
			unless current_supplier.supplier_account.blank?
				unless current_supplier.supplier_account.conversations.blank?
					@supplier_conversations_unread_count = current_supplier.supplier_account.conversations.joins(:messages).where("messages.supplier_read = 0 or messages.supplier_read is null").count
				end
			end
		end
	end
	
	def count_unread_bookings
		if supplier_signed_in?
			unless current_supplier.supplier_account.events.blank?
				@supplier_no_confirmed_bookings = current_supplier.supplier_account.events.where(:booking_confirmed => false).count
			end
		end
	end

	def alvi?
		if user_signed_in?
			return current_user.alvi?			
		end
		if supplier_signed_in?
			return current_supplier.alvi?			
		end
		return false
	end
	
	def developer?
		if user_signed_in?
			return current_user.developer?			
		end
		if supplier_signed_in?
			return current_supplier.developer?			
		end
		return false
	end
	
	def admin?
		if user_signed_in?
			return current_user.admin?			
		end
		false
	end
	
	def redirect_unless_admin
		if user_signed_in?
			redirect_to blog_url unless current_user.role_id == 1
		else
			redirect_to blog_url
		end
	end
	
	def redirect_unless_privilege(privilege_name)
	  redirect = false
	  if !current_user.matriclicker.nil?
	    privilege = Privilege.find_by_name privilege_name
	    if !(current_user.matriclicker.privileges.include? privilege)
        redirect = true
      end
    else 
      redirect = true
    end
    if redirect
      redirect_to blog_url
    end
  end
  
  def check_privilege(privilege_name)
	  if !current_user.matriclicker.nil?
	    privilege = Privilege.find_by_name privilege_name
	    if !(current_user.matriclicker.privileges.include? privilege)
        false
      else
        true
      end
    else 
      false
    end
  end
  
  def redirect_unless_owner_or_admin(purchasable)
    if user_signed_in?
      is_admin = !current_user.matriclicker.nil?
      is_owner = false
      current_user.purchases.each do |p|
        is_owner = true if p.purchasable == purchasable
      end
    
      if !is_admin and !is_owner
        redirect_to blog_url
      end
    else
      redirect_to blog_url
    end
  end
  
  def redirect_unless_admin_or_supplier
    if supplier_signed_in? or user_signed_in?
      is_supplier = !current_supplier.nil?
      if !is_supplier
        is_admin = !current_user.matriclicker.nil?
        if !is_admin
          redirect_to blog_url
        end
      end
    else
      redirect_to blog_url
    end
  end
  
  def authenticate_guest
		if !user_signed_in?
			
			# DZF creating and login_in an invitee user.
			ua = User.find_by_email("demo@matriclick.com").user_account

			u = User.new
			email = u.email ="invitado_matriclick@"+rand(9999).to_s+"-"+Time.now.to_s.gsub(/(\s|\D)/, "")+".cl"
			u.role_id = 3
			u.user_account_id = ua.id
			
			u.skip_confirmation!
			u.save(:validate => false)
			sign_in(:user, User.find_by_email(email))
			
			# HH Why was this redirect_to here? (I commented it)
			# redirect_to blog_path
		end
  end

	def load_budget_slots
		if user_signed_in? and current_user.role_id != 3
		  unless current_user.user_account.nil?
			  if current_user.user_account.budget_slots.blank?
				  current_user.user_account.update_attribute(:budget_distribution_type_id, BudgetDistributionType.where('name like "%Equitativo%"').first.id)
				  IndustryCategory.all.joins(:countries).where("countries.id = ?", session[:country].id).each { |ic| current_user.user_account.budget_slots << BudgetSlot.create!(industry_category_id: ic.id, budget_distribution_type_id: BudgetDistributionType.where("name like '%Equitativo%'").first.id, budget_type_id: BudgetType.find_by_name("$$").id) }
			  end
		  end
		end
	end

	def check_env
		unless Rails.env == "development"
			redirect_to root_country_path
		end
	end
  
  def numeric?(object)
    true if Float(object) rescue false
  end
  
  def set_type_param
    @type_param = !params[:type].nil? ? params[:type] : ''
  end
  
  private

  MOBILE_BROWSERS = ["playbook", "windows phone", "android", "ipod", "iphone", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def detect_browser
    if !request.headers["HTTP_USER_AGENT"].nil?
      agent = request.headers["HTTP_USER_AGENT"].downcase

      MOBILE_BROWSERS.each do |m|
        return "mobile" if agent.match(m)
      end
    end
    return "desktop"
  end
  
  
end
