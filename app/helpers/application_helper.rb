module ApplicationHelper
  # Helpers to build sortable tables
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
  
  def check_top_menu
    return session[:matriclick_top_menu]
  end
  
	# These helpers are needed to display a sign_in/up form anywhere in the app.
	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def pluralize_without_number(count, singular, plural = nil)
		pluralize(count, singular, plural).split.last
	end

	def number_to_rut(rut)
		check_digit = rut.last
		rut_aux = rut.chop
		rut_aux = rut_aux.to_i
    rut_aux = number_with_delimiter(rut_aux, :delimiter => ".")
    rut_s = rut_aux.to_s()+"-"+check_digit
    return rut_s
  end

	def mark_required(object, attribute)  
	  content_tag :span, "*", :class => :required if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator  
  end

	def crop_if_longer(string, length)
		if string.length > length
			string[0..length-1]+"..."
		else
			string
		end
	end
	
	def link_to_cycle(object, move = :next, options)
		options[:scope].present? ? @objects = eval("#{object.class}.#{options[:scope].to_s}") : @objects = object.class.all
	
		@index = @objects.index(object)
		if move == :next
			if @objects.last == object
				@next_object = @objects.first
			else
				@next_object = @objects.at(@index + 1)
			end
		elsif move == :prev
			if @objects.first == object
				@next_object = @objects.last
			else
				@next_object = @objects.at(@index - 1)
			end
		end
		if options[:target]
			link_to "", eval("#{options[:target]}(#{@next_object.id})"), :class => options[:css_class]	
		else
			link_to "", @next_object, :class => options[:css_class]	
		end
		
	end
	
	def link_to_next(name, object, css_class = nil)
		@supplier_account = SupplierAccount.find(object.supplier_account_id)
		@objects = @supplier_account.products + @supplier_account.services
		@index = @objects.index(object)
		
		if @objects.last == object	
			@next_object = @objects.first
		else
			@next_object = @objects.at(@index + 1)
		end
		element = @next_object.class.to_s.downcase
		
		return link_to(name, eval("products_and_services_catalog_description_path(#{@next_object.id.to_s}, :object_class => #{@next_object.class})"), :class => css_class )
	end
	
	def link_to_previous(name, object, css_class = nil)
		@supplier_account = SupplierAccount.find(object.supplier_account_id)
		@objects = @supplier_account.products + @supplier_account.services
		@index = @objects.index(object)

		if @objects.first == object
			@previous_object = @objects.last
		else
			@previous_object = @objects.at(@index - 1)
		end
		element = @previous_object.class.to_s.downcase
		return link_to(name, eval("products_and_services_catalog_description_path(#{@previous_object.id.to_s}, :object_class => #{@previous_object.class})"), :class => css_class )
	end
	
	def has_more_than_one?(object)
		object.supplier_account.services_and_products_count > 1
	end
	
	def check_if_privilege(privilege_name)
    if !current_user.matriclicker.nil?
	    privilege = Privilege.find_by_name privilege_name
	    if !(current_user.matriclicker.privileges.include? privilege)
        return false
      else
        return true
      end
    else 
      return false
    end
  end

  def get_industry_name(ic_id) 
    ic = IndustryCategory.find(ic_id)
    return ic.get_name
  end

  def get_sub_industry_name(sic_id) 
    sic = SubIndustryCategory.find(sic_id)
    return sic.get_name
  end
  
  def should_show_items_link(supplier)
    supplier.supplier_account.industry_categories.each do |industry_category|
    	if ['vestidos_de_fiesta', 'vestidos_y_calzado_novia', 'ajuar'].include?(industry_category.name) and supplier_signed_in?
    		return true
    	end
    end
    return false  
  end
    
	def admin?
		if user_signed_in?
			return current_user.admin?			
		end
		false
	end
	
	def alvi?
		if user_signed_in?
			return current_user.alvi?			
		end
		if supplier_signed_in?
			return current_supplier.alvi?			
		end
		false
	end
	
	def developer?
		if user_signed_in?
			return current_user.developer?			
		end
		if supplier_signed_in?
			return current_supplier.developer?			
		end
		false
	end
end
