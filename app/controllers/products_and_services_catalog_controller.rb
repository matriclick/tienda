# encoding: UTF-8
require 'will_paginate/array'
class ProductsAndServicesCatalogController < ApplicationController
  before_filter :redirect
  
  def redirect
    redirect_to bazar_path
  end
  
  #before_filter :new_feedback, :load_user_account, :load_reference, :load_categories_with_albums
  #before_filter :authenticate_user!, :only => [:conversations, :bookings, :add_booking]
  #before_filter :redirect_if_object_class_nil, :only => [:description, :faqs, :contacts, :conversations, :add_to_budget]
  
  add_breadcrumb "Catálogo", :products_and_services_catalog_select_industry_category_path

  @@scrolling_set = 8
  
  def endless_scrolling    
    splited_ids = params[:ids].split(',')
    pending_photos_ids = splited_ids[@@scrolling_set..splited_ids.length-1]
    @photos_ids = pending_photos_ids.to_s.gsub("\"","").gsub("[",'').gsub("]",'').gsub(" ",'')
    pending_photos_count = pending_photos_ids.blank? ? 0 :  pending_photos_ids.count
    @last_set =  pending_photos_count<=@@scrolling_set    
    @album_photos = Array.new

    for p in 0..[@@scrolling_set-1,pending_photos_count-1].min
    @album_photos.push(AlbumPhoto.find(pending_photos_ids[p]))    
    end
    #Responde a  endless_scrolling.js.erb       
  end
  
  # ACCIONES PARA BUSCAR PROVEEDORES O PRODUCTOS Y SERVICIOS
  
  def select_industry_category
		@industry_categories = IndustryCategory.all.joins(:countries).where("countries.id = ?", session[:country].id).order "position"
		@watch = "IndustryCategory"

  	@title_content = 'Servicios para tu Matrimonio'
  	@meta_description_content = 'Encuentra todos los servicios y productos que necesitas para la organización de tu matrimonio y aprovecha las oportunidades especiales que tenemos para ti'

	end
	
	def products_and_services
	  if numeric?(params[:industry_category_ids])
		  @industry_category = IndustryCategory.find params[:industry_category_ids]
		  if !@industry_category.nil?
		    redirect_to products_and_services_catalog_all_services_path(:industry_category_ids => @industry_category.slug)
	    else
	      redirect_to products_and_services_catalog_select_industry_category_path
	    end
    else
  		@industry_category = IndustryCategory.find_by_slug params[:industry_category_ids]
      @sub_industries = @industry_category.sub_industry_categories.order 'position ASC'

    	@title_content = 'Productos y servicios de '+@industry_category.get_name
    	@meta_description_content = 'Encuentra todos los servicios y productos de '+@industry_category.name+' que necesitas para la organización de tu matrimonio y aprovecha las oportunidades especiales que tenemos para ti'
      add_breadcrumb @industry_category.get_name, products_and_services_catalog_index_path(:industry_category_ids => @industry_category.slug)

      @objects = Product.search(@industry_category.id).alphabetized.approved
  	  @objects += Service.search(@industry_category.id).alphabetized.approved
  	  @objects_count = @objects.count
      @objects = @objects.paginate(:page => params[:page], :per_page => 12)
    
      respond_to do |format|
  			format.html # index.html.erb
  			format.js
  		end
		end
  end
  
  def with_or_without_account
    if numeric?(params[:industry_category_ids])
		  @industry_category = IndustryCategory.find params[:industry_category_ids]
		  if !@industry_category.nil?
		    redirect_to products_and_services_catalog_all_suppliers_path(:industry_category_ids => @industry_category.slug)
	    else
	      redirect_to products_and_services_catalog_select_industry_category_path
	    end
    else
  		@industry_category = IndustryCategory.find_by_slug params[:industry_category_ids]
      @sub_industries = @industry_category.sub_industry_categories.order 'position ASC'

    	@title_content = 'Todos los proveedores de '+@industry_category.get_name
    	@meta_description_content = 'Encuentra todos los servicios y productos de '+@industry_category.name+' que necesitas para la organización de tu matrimonio y aprovecha las oportunidades especiales que tenemos para ti'
      add_breadcrumb @industry_category.get_name, products_and_services_catalog_index_path(:industry_category_ids => @industry_category.slug)
      
  		@sat = SupplierAccountType.find_by_name('Regular')

  	  @supplier_without_accounts = SupplierWithoutAccount.
  	                                where(:industry_category_id => @industry_category.id).
  	                                order(:corporate_name)
	  
      @supplier_with_accounts = SupplierAccount.where(:country_id => session[:country].id).
                                    by_industry_category(@industry_category.id).where(:supplier_account_type_id => @sat.id).
                                    approved.order(:corporate_name)

      respond_to do |format|
  			format.html # index.html.erb
  			format.js
  		end  
		end
  end
  
  def album
    if numeric?(params[:industry_category_ids])
		  @industry_category = IndustryCategory.find params[:industry_category_ids]
		  if !@industry_category.nil?
		    redirect_to products_and_services_catalog_album_path(:industry_category_ids => @industry_category.slug)
	    else
	      redirect_to products_and_services_catalog_select_industry_category_path
	    end
    else
      @album_industry_names = %w[banqueteras fotografia_y_video]
  		@industry_category = IndustryCategory.find_by_slug params[:industry_category_ids]
      @sub_industries = @industry_category.sub_industry_categories.order 'position ASC'
    
      @title_content = 'Album de imágenes de '+@industry_category.get_name
    	@meta_description_content = 'Encuentra todos los servicios y productos de '+@industry_category.name+' que necesitas para la organización de tu matrimonio y aprovecha las oportunidades especiales que tenemos para ti'
  	  add_breadcrumb @industry_category.get_name, products_and_services_catalog_index_path(:industry_category_ids => @industry_category.slug)
  	
      photos_per_supplier_account = 30
      @album_photos = []
    
      supplier_account_type_regular = SupplierAccountType.find_by_name('Regular')
      supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).by_industry_category(@industry_category.id).where(:supplier_account_type_id => supplier_account_type_regular.id).approved

      supplier_accounts.each do |supplier_account|
        supplier_account_photos = []
        albums = supplier_account.albums
        albums.visible.each do |album|
          if album.industry_category.id == @industry_category.id
            album.album_photos.visible.each do |album_photo|
              supplier_account_photos << album_photo
            end
          end
        end
        supplier_account_photos.shuffle!
        photos_per_supplier_account.times do
          if supplier_account_photos.size > 0
            supplier_accounts_photo_selected = supplier_account_photos.first
            @album_photos << supplier_accounts_photo_selected
            supplier_account_photos.delete(supplier_accounts_photo_selected)
          end
        end
      end
      @album_photos.shuffle!


      #endless scrolling  
      #IE v8 y anteriores no compatible con carga dinamica
      user_agent = request.env['HTTP_USER_AGENT']
      unless user_agent =~ /MSIE 8/ || user_agent =~ /MSIE 7/ || user_agent =~ /MSIE 6/ || user_agent =~ /MSIE 5/       
        @photos_ids ="";
        @scrolling_set = @@scrolling_set
        @album_photos.each do |photo|
          @photos_ids += photo.id.to_s + ','
        end
        @album_photos = @album_photos[0..@@scrolling_set-1]
      else
        @scrolling_set = @album_photos.length + 1
      end

      respond_to do |format|
  			format.html # index.html.erb
  			format.js
  		end
		end
  end
  
  def index
    if numeric?(params[:industry_category_ids])
		  @industry_category = IndustryCategory.find params[:industry_category_ids]
		  if !@industry_category.nil?
		    redirect_to products_and_services_catalog_index_path(:industry_category_ids => @industry_category.slug)
	    else
	      redirect_to products_and_services_catalog_select_industry_category_path
	    end
    else
		  @industry_category = IndustryCategory.find_by_slug params[:industry_category_ids]    
      if @industry_category.nil?
        redirect_to products_and_services_catalog_select_industry_category_path
      else
        @sub_industries = @industry_category.sub_industry_categories.order 'position ASC'
        @title_content = @industry_category.get_name
      	@meta_description_content = 'Encuentra todos los servicios y productos de '+@industry_category.name+' que necesitas para la organización de tu matrimonio y aprovecha las oportunidades especiales que tenemos para ti'
        add_breadcrumb @industry_category.get_name, products_and_services_catalog_index_path(:industry_category_ids => @industry_category.slug)
        
    		respond_to do |format|
    			format.html # index.html.erb
    			format.js
    		end
      end
	  end
  end
  
  def supplier_without_account_info
    @supplier = SupplierWithoutAccount.find params[:id]
    
    respond_to do |format|
  		format.html {render :layout => false}
  	end
  end
  
  # ACCIONES PARA REVISAR PRODUCTOS O SERVICIOS
  
  def description
		if params[:preview]
      session[:preview] = true
    end
    
    @object = find_product_or_service(params[:slug])
    
    if @object.nil?
      redirect_to products_and_services_catalog_select_industry_category_path
    else    
      @description = @object.description
      @supplier = @object.supplier_account.supplier
  		@schedule = @object.schedule if @object.is_a? Service
      @title_content = @supplier.supplier_account.fantasy_name+': '+@object.name+' | Descripción'
    	@meta_description_content = @supplier.supplier_account.fantasy_name+' | '+@object.name+': '+@object.description
      products_and_services_breadcrumbds(@object)
    end
    if numeric? params[:slug]
      redirect_to products_and_services_catalog_description_path(:slug => @object.slug)
    end
  end

  def faqs
    @object = find_product_or_service(params[:slug])
    
    if @object.nil?
      redirect_to products_and_services_catalog_select_industry_category_path
    else
  	  if @object.class.to_s == "Product"
    		@faqs = @object.product_faqs
    	elsif @object.class.to_s == "Service"
  			@faqs = @object.service_faqs
    	end
  		@supplier = @object.supplier_account.supplier
      @title_content = @supplier.supplier_account.fantasy_name+': '+@object.name+' | Preguntas Frecuentes'
    	@meta_description_content = @supplier.supplier_account.fantasy_name+' | '+@object.name+' resuelve las preguntas sobre este servicio'      
    	products_and_services_breadcrumbds(@object)
    end
    if numeric? params[:slug]
      redirect_to products_and_services_catalog_faqs_path(:slug => @object.slug)
    end
  end
  
  def contacts
    @object = find_product_or_service(params[:slug])
    
    if @object.nil?
      redirect_to products_and_services_catalog_select_industry_category_path
    else
    	@supplier = @object.supplier_account.supplier
    	@supplier_contacts = @object.supplier_account.supplier_contacts
      @title_content = @supplier.supplier_account.fantasy_name+': '+@object.name+' | Contacto'
    	@meta_description_content = @supplier.supplier_account.fantasy_name+' | '+@object.name+': datos de contacto para reservar o comprar el servicio o producto'
    	products_and_services_breadcrumbds(@object)
	  end
	  if numeric? params[:slug]
      redirect_to products_and_services_catalog_contacts_path(:slug => @object.slug)
    end
    
  end
  
  def conversations
    @object = find_product_or_service(params[:slug])
    if @object.nil?
      redirect_to products_and_services_catalog_select_industry_category_path
    else
    	@supplier = @object.supplier_account.supplier
    	@enable_conversation = true if @object.supplier_account.approved_by_us
    	@conversation = @object.conversations.by_user(current_user).first
    	@transmitter = current_user.user_account.get_wedding_name
   		if @conversation.blank?
   			@is_new = true
   			@conversation = Conversation.new
   			@message = @conversation.messages.build
   		else
   			@is_new = false
   			@message = Message.new
   			@conversation.messages.each do |message|
   				message.update_attributes(:user_read => true)
   			end
   		end
      @title_content = @supplier.supplier_account.fantasy_name+': '+@object.name+' | Mensajes'
    	@meta_description_content = @supplier.supplier_account.fantasy_name+' | '+@object.name+': contacta a '+@supplier.supplier_account.fantasy_name+' para coordinar'
    	products_and_services_breadcrumbds(@object)
    end
    if numeric? params[:slug]
      redirect_to products_and_services_catalog_description(:slug => @object.slug)
    end
    
  end

	# GET
  def add_to_budget
  	@object = eval(params[:object_class]).find params[:id]
	  if user_signed_in?
	  	@object.add_to_budget(params[:budget_price], params[:budget_type_id], current_user.user_account)
		end
	  respond_to do |format|
	  	format.html {redirect_to :back}
	  end
  end
  
  def download_file
  	@attached_file = AttachedFile.find params[:attached_file]
  	send_file @attached_file.attached.path, :type => @attached_file.attached_content_type, :filename => @attached_file.attached_file_name
  end
  
  def redirect_if_guest
  	if current_user.role_id == 3
  		if params[:action] == "bookings"
  			redirect_to :action => :description, :object_class => "Service"
  		else
  			@object = eval(params[:object_class]).find params[:id]
  			redirect_to :action => :description, :object_class => @object.class
  		end  		
  	end
  end
  
  def redirect_if_object_class_nil
    if params[:slug].nil?
      redirect_to products_and_services_catalog_select_industry_category_path
    end
	end
	
	def load_categories_with_albums
      @album_industry_names = %w[banqueteras fotografia_y_video]
  end
  
  def products_and_services_breadcrumbds(object)
    add_breadcrumb @object.supplier_account.main_industry_category.get_name, products_and_services_catalog_index_path(:industry_category_ids => @object.supplier_account.main_industry_category.slug)
    add_breadcrumb object.supplier_account.fantasy_name, supplier_products_and_services_path(:public_url => object.supplier_account.public_url)
    add_breadcrumb object.name, products_and_services_catalog_description_path(:slug => object.slug)
  end

end
