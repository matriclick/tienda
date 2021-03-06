# encoding: UTF-8
class SuppliersCatalogController < ApplicationController
	before_filter :add_breadcrumbs, :except => ['supplier_description']
  before_filter :redirect_unless_admin, :except => ['supplier_description']
  	
  def supplier_description
    @supplier = check_supplier
    
		if !@supplier.nil?
      add_breadcrumb 'Tramanta.com', root_path
      add_breadcrumb @supplier.supplier_account.fantasy_name, supplier_description_path(:public_url => @supplier.supplier_account.public_url)      

			@presentation = @supplier.supplier_account.presentation
			@supplier_account = @supplier.supplier_account
      unless @supplier.supplier_account.nil?
        unless @supplier.supplier_account.address.nil?
          if !@supplier.supplier_account.address.latitude.nil? and !@supplier.supplier_account.address.longitude.nil?
    		    @show_map = true
    		    @map = @supplier.supplier_account.address
  	      end
  	    end
        @title_content = @supplier.supplier_account.fantasy_name
      	@meta_description_content = '¡'+@supplier.supplier_account.fantasy_name+' está en Tramanta.com! Conoce todos sus productos y compra paga online usando tus tarjetas de crédito o débito'
        load_facebook_meta(@supplier)
        disp = DressStatus.find_by_name("Disponible").id
        @all_dresses =  @supplier_account.dresses.where('dress_status_id = ?', disp).order('created_at DESC')
        @search_text = 'Busca por color, talla, tela, etc...'

        @dresses = @all_dresses.paginate(:page => params[:page]).order(@order)
        @sizes = Dress.check_sizes(@all_dresses)
        @title_content = @supplier_account.fantasy_name.capitalize
      	@meta_description_content = 'Compra en '+@supplier_account.fantasy_name.capitalize
      end
    else
      redirect_to root_path
    end
  end
  
  def supplier_products_and_services
		if params[:preview]
      session[:preview] = true
    end
    
  	@supplier = check_supplier

  	if @supplier.nil?
			redirect_to root_path
		else
  		# FGM: Increase Page Views counter
  		@supplier.supplier_account.add_supplier_page_view(request.ip)
    	@products = @supplier.supplier_account.products.order(:place)
  		@services = @supplier.supplier_account.services.order(:place)
  		@presentation = @supplier.supplier_account.presentation

  		check_if_dress_store(@supplier)
  		check_if_trousseau(@supplier)
		
  		#Cargo los items si es tienda boutique o si tiene ajuar en sus categorías
  		if @vestido_boutique or @trousseau
  		  @dresses_array = Array.new
  		  @supplier.supplier_account.dresses.available.each do |dress|
            @dresses_array.push(dress)
        end
        @dresses_array.sort_by! {|dr| [dr.position.nil? ? 999 : dr.position, -dr.dress_requests.count, -dr.id] }
  		end
		
      unless @supplier.nil?
        unless @supplier.supplier_account.nil?
          unless @supplier.supplier_account.presentation.nil?
            @meta_description_content = @supplier.supplier_account.presentation.description
          end
        end
      end
      if user_signed_in?
        @user = current_user
        @selections = @user.user_contest_selections
      end

      @title_content = @supplier.supplier_account.fantasy_name+' | Productos y Servicios'
    	@meta_description_content = '¡'+@supplier.supplier_account.fantasy_name+' está en Matriclick! Revisa sus productos y servicios, contáctalo y cotiza, una vez estés decidido, paga online usando tus tarjetas de crédito o débito'
      load_facebook_meta(@supplier)
		end    
  end

	def supplier_contacts
		@supplier = check_supplier
		if @supplier.nil?
			redirect_to products_and_services_catalog_select_industry_category_path
		else
  		@supplier.supplier_account.add_supplier_page_view(request.ip, 'Contacto')
  		@supplier_contacts = @supplier.supplier_account.supplier_contacts
  		@presentation = @supplier.supplier_account.presentation
  		check_if_dress_store(@supplier)

      unless @supplier.nil?
        unless @supplier.supplier_account.nil?
          unless @supplier.supplier_account.presentation.nil?
            @meta_description_content = @supplier.supplier_account.presentation.description
          end
        end
      end
    
      @title_content = @supplier.supplier_account.fantasy_name+' | Contacto'
    	@meta_description_content = '¡'+@supplier.supplier_account.fantasy_name+' está en Matriclick! Revisa sus productos y servicios, contáctalo y cotiza, una vez estés decidido, paga online usando tus tarjetas de crédito o débito'
      load_facebook_meta(@supplier)    
    end
	end
	
	def supplier_calendar
	  @supplier = check_supplier
	  if @supplier.nil?
			redirect_to products_and_services_catalog_select_industry_category_path
		else
		  @presentation = @supplier.supplier_account.presentation
  		@reserved_dates = @supplier.supplier_account.reserved_dates
  		@date_selector = params[:year] ? Date.parse(params[:year]) : Date.today
  		check_if_dress_store(@supplier)

      unless @supplier.nil?
        unless @supplier.supplier_account.nil?
          unless @supplier.supplier_account.presentation.nil?
            @meta_description_content = @supplier.supplier_account.presentation.description
          end
        end
      end
    
      @title_content = @supplier.supplier_account.fantasy_name+' | Calendario de Disponibilidad'
    	@meta_description_content = '¡'+@supplier.supplier_account.fantasy_name+' está en Matriclick! Revisa sus productos y servicios, contáctalo y cotiza, una vez estés decidido, paga online usando tus tarjetas de crédito o débito'
      load_facebook_meta(@supplier) 
    end   
  end
	  	
  def supplier_reviews
    @supplier = check_supplier
	  if @supplier.nil?
  		redirect_to products_and_services_catalog_select_industry_category_path
  	else
  		@presentation = @supplier.supplier_account.presentation
  		#star rating
  		@reviews = @supplier.supplier_account.reviews.approved.order 'created_at DESC'
  		unless @reviews.blank?
  			@average_star_rating = 0
  			@reviews.each do |rev|
  				@average_star_rating += rev.star_rating.value
  			end
  			@average_star_rating = @average_star_rating / @reviews.count
  			#review content
  			@review_content = @supplier.supplier_account.reviews.order('rand()').first.content
  		end
  		check_if_dress_store(@supplier)

      unless @supplier.nil?
        unless @supplier.supplier_account.nil?
          unless @supplier.supplier_account.presentation.nil?
            @meta_description_content = @supplier.supplier_account.presentation.description
          end
        end
      end
    
      @title_content = @supplier.supplier_account.fantasy_name+' | Comentarios y Referencias'
    	@meta_description_content = '¡'+@supplier.supplier_account.fantasy_name+' está en Matriclick! Revisa sus productos y servicios, contáctalo y cotiza, una vez estés decidido, paga online usando tus tarjetas de crédito o débito'
      load_facebook_meta(@supplier)    
    end
	end
	
	private

	def check_supplier
	  if params[:public_url] #DZF When is writted a supplierAccount.public_url int the URL, here we found the Supplier of that SupplierAccount
    	unless SupplierAccount.where(:public_url => params[:public_url]).first.blank?
    		supplier = Supplier.find(SupplierAccount.where(:public_url => params[:public_url]).first.supplier_id)
    	end
    end
    return supplier
  end
  	
  def load_facebook_meta(supplier)
    @og_type = 'article'
    @og_image = 'http://www.tramanta.com'+supplier.supplier_account.image.url(:original)
    @og_description = supplier.supplier_account.presentation
  end
  
  def add_breadcrumbs
    supplier = check_supplier
    if !current_supplier.nil?
      add_breadcrumb "Cuenta", supplier_account_path(current_supplier.supplier_account)
      add_breadcrumb current_supplier.supplier_account.fantasy_name, supplier_description_path(:public_url => current_supplier.supplier_account.public_url)      
    elsif !supplier.nil?
      add_breadcrumb "Administrador", :administration_index_path
      add_breadcrumb "Lista de tiendas", :administration_suppliers_list_path
      add_breadcrumb supplier.supplier_account.fantasy_name, supplier_description_path(:public_url => supplier.supplier_account.public_url)      
    end
  end
end
