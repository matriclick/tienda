# encoding: UTF-8
class AdministrationController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  
  def mailing_tools
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.yesterday
      @to = DateTime.now
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @send = params[:send]
    @users = User.get_all_with_tag
    @dresses = Dress.get_all_with_tag(@from, @to)
    #mail_infos tiene un hash { user_id => [dress_id] }
    @mail_infos = Mailing.get_personalized_mailing_information(@users, @dresses)
    
  end
  
  def mailing_sent
    @from = Time.parse(params[:from])
    @to = Time.parse(params[:to])
    
    @send = params[:send]
    @users = User.get_all_with_tag
    @dresses = Dress.get_all_with_tag(@from, @to)
    
    #mail_infos tiene un hash { user_id => [dress_id] }
    @mail_infos = Mailing.get_personalized_mailing_information(@users, @dresses)
    
    Mailing.create(:date_sent => DateTime.now, :users_sent => @mail_infos.size, :dresses_start_date => @from.strftime("%Y-%m-%d"), :dresses_end_date => @to.strftime("%Y-%m-%d"))
    @mail_infos.each do |user_id, dresses_id|
      if dresses_id.size > 0
        MassiveMailer.send_personalized_email(user_id, dresses_id).deliver
      end
    end
    redirect_to mailings_path
  end
    
  # GET
  def index
    if !current_user.matriclicker.nil?
      @matriclicker = current_user.matriclicker
    else 
      redirect_to blog_url
    end
  end
  
  def webpage_contacts
    redirect_unless_privilege('Contactos')
    
    @type = params[:type]
    
    if @type == "Feedback".to_s
      @objects = Feedback.all
    else
      @objects = Contact.all
    end
    
  end
    
  # GET
  def suppliers_list
    redirect_unless_privilege('Proveedores')
    
    @search_term = params[:q]
    @filter = params[:filter]
    @type = !params[:type].nil? ? params[:type] : 'all'
    
    if @type == 'all'    
      if (@search_term.nil? or @search_term.empty?) and (@filter.nil? or @filter.empty?)
        @suppliers = Supplier.order('created_at DESC').limit 20
      elsif !(@search_term.nil? or @search_term.empty?)
        @suppliers = Supplier.joins(:supplier_account => :supplier_account_type).
        where('supplier_accounts.fantasy_name like "%'+@search_term+'%" or supplier_account_types.name like "%'+@search_term+'%"');
      else
        @suppliers = Supplier.all
      end
    else
        sa_type = SupplierAccountType.find_by_name('Regular')
        
        @suppliers = Supplier.joins(:supplier_account => :supplier_account_type).
        where('supplier_account_types.id <> ?', sa_type.id)
    end
  end
  
  def dresses_list
    redirect_unless_privilege('Vestidos')
    wedding_dress = DressType.find_by_name('vestidos-novia')
    @dresses = wedding_dress.dresses
  end
  
  def dresses
    redirect_unless_privilege('Vestidos')
    @dresses = Dress.where('supplier_account_id is not null')
    @dresses_count = @dresses.count
    @dresses = @dresses.paginate(:page => params[:page], :per_page => 48)
  end
  
  def dress
    redirect_unless_privilege('Vestidos')
    @dress = Dress.find params[:id]
    @supplier = @dress.supplier_account.supplier
    @enable_edit = true
  end
  
  def old_dresses
    redirect_unless_privilege('Vestidos')
    type = params[:type]
    
    if type == 1.to_s
      @dresses = Dress.where('supplier_account_id is null and dress_type_id = 1')
    else
      @dresses = Dress.where('supplier_account_id is null and dress_type_id = 2')
    end
    
    @dresses_count = @dresses.count
    @dresses = @dresses.paginate(:page => params[:page], :per_page => 12)
  end
  
  def view_old_dress
    redirect_unless_privilege('Vestidos')
    @dress = Dress.find params[:id]
  end

  # DELETE /dresses/1
  # DELETE /dresses/1.json
  def destroy_old_dress
    redirect_unless_privilege('Vestidos')
    
    @dress = Dress.find(params[:id])
    @dress.destroy

    respond_to do |format|
      format.html { redirect_to administration_old_dresses_path }
      format.json { head :ok }
    end
  end
  
	# GET
  #Muestra el perfil de la cuenta (Está redireccionada a supplier/main)
  def show_supplier_account
    redirect_unless_privilege('Proveedores')
  	@supplier_account = SupplierAccount.find params[:id]
  end
  
	# GET
  #Muestra los productos de un proveedor (Está anidado a /suppliers/:id/supplier_account/products)
  def show_supplier_products
    redirect_unless_privilege('Proveedores')
  	@supplier_account = SupplierAccount.find params[:id]
  	@products = @supplier_account.products
  end

	# GET
  #Muestra los servicios que ofrece un proveedor (Está anidado a /suppliers/:id/supplier_account/services)
  def show_supplier_services
    redirect_unless_privilege('Proveedores')
  	@supplier_account = SupplierAccount.find params[:id]
  	@services = @supplier_account.services
  end

	# GET
  #Edita el perfil del proveedor (Está anidado a /suppliers/:id/supplier_account/edit)
  def edit_supplier_account
    redirect_unless_privilege('Proveedores')
  	@supplier_account = SupplierAccount.find params[:supplier_account_id]
		@industry_categories = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).order "name"
    @industry_category_types = IndustryCategoryType.all
  end
  
  def reset_supplier_password
    redirect_unless_privilege('Proveedores')
    @supplier_account = SupplierAccount.find params[:supplier_account_id]
    @token = Time.now.to_s
    @supplier_account.supplier.update_attribute :reset_password_token, @token
    @supplier_account.supplier.update_attribute :reset_password_sent_at, Time.now
  end

	# GET
  #Edita los productos ofrecidos por el proveedor (Se muestran en el edit_supplier_account)
  def edit_supplier_product  
    redirect_unless_privilege('Proveedores')
  	@product = Product.find params[:product_id]
  	@product.videos.build if @product.videos.blank?
	  @supplier_account = @product.supplier_account
	  @supplier = @product.supplier_account.supplier
		@product_types = ProductType.of_supplier @supplier
		@industry_categories = @supplier_account.industry_categories.where(:industry_category_type_id => 1) if @supplier_account.industry_categories.where(:industry_category_type_id => 1).count > 0
		@industry_cat_types = @industry_categories.inject({}) do |options, industry_category|
		  (options[industry_category.industry_category_type.name] ||= []) << [industry_category.get_name, industry_category.id]
  		options
		end
   # product_faqs = @product.product_faqs.build
  end

	# GET
  #Edita los servicios ofrecidos por el proveedor (Se muestran en el edit_supplier_account)

  def edit_supplier_service
    redirect_unless_privilege('Proveedores')
  	@not_deliverable_services_ids = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).where(industry_category_type_id:2).map(&:id) 
  	@service = Service.find params[:service_id]
  	@service.videos.build if @service.videos.blank?
  	@supplier_account = @service.supplier_account
  	@supplier = @service.supplier_account.supplier
    @color_types = ColorType.all
		@industry_categories = @industry_categories = @supplier_account.industry_categories.where("industry_category_type_id = 3 OR industry_category_type_id = 2")
		#DZF here I make the dynamic grouped_options_for_select options
		@industry_cat_types = @industry_categories.inject({}) do |options, industry_category|
		  (options[industry_category.industry_category_type.name] ||= []) << [industry_category.get_name, industry_category.id]
  		options
		end
  end

	# PUT
  def update_supplier_account
    redirect_unless_privilege('Proveedores')
  	@supplier_account = SupplierAccount.find params[:id]
  	
  	respond_to do |format|
  		if @supplier_account.update_attributes(params[:supplier_account], :validate => false)
  			format.html { redirect_to administration_show_supplier_account_path(@supplier_account) }
  		else
				@industry_categories = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).order "name"
		    @industry_category_types = IndustryCategoryType.all
  			format.html { render action: 'edit_supplier_account'}
  			format.json { render json: @supplier_account.errors, status: :unprocessable_entity }
  		end
  	end
  end
  
	# PUT
  def update_supplier_product
    redirect_unless_privilege('Proveedores')
  	@product = Product.find params[:id]
    
  	respond_to do |format|
  		if @product.update_attributes(params[:product])
  			format.html { redirect_to administration_show_supplier_products_path(@product.supplier_account)}
  		else
				@product = Product.find params[:id]
				@supplier_account = @product.supplier_account
				@supplier = @product.supplier_account.supplier
				@product_types = ProductType.of_supplier @supplier
				@industry_categories = @supplier_account.industry_categories.where(:industry_category_type_id => 1) if @supplier_account.industry_categories.where(:industry_category_type_id => 1).count > 1
  			format.html {render action: 'edit_supplier_product'}
  			format.json { render json: @product.errors, status: :unprocessable_entity }
  		end
  	end
  end

	# PUT
  def update_supplier_service
    redirect_unless_privilege('Proveedores')
  	@service = Service.find params[:id]
    
  	respond_to do |format|
  		if @service.update_attributes(params[:service])
  			format.html { redirect_to administration_show_supplier_services_path(@service.supplier_account)}
  		else
				@service = Service.find params[:id]
				@supplier_account = @service.supplier_account
				@supplier = @service.supplier_account.supplier
				@color_types = ColorType.all
				@industry_categories = @supplier_account.industry_categories.where("industry_category_type_id = 3 OR industry_category_type_id = 2")
				#DZF here I make the dynamic grouped_options_for_select options
				@industry_cat_types = @industry_categories.inject({}) do |options, industry_category|
					(options[industry_category.industry_category_type.name] ||= []) << [industry_category.get_name, industry_category.id]
					options
				end
  			format.html {render action: 'edit_supplier_service'}
  			format.json { render json: @service.errors, status: :unprocessable_entity }
  		end
  	end
  end
  
	# DELETE
  def destroy_supplier
    redirect_unless_privilege('Proveedores')
  	@supplier = Supplier.find params[:id]
  	@supplier.destroy
  	
  	respond_to do |format|
  			format.html { redirect_to action: 'suppliers_list'}
  	end
  end
  
	# DELETE
  def destroy_supplier_product
    redirect_unless_privilege('Proveedores')
  	@product = Product.find params[:id]
  	@supplier = Supplier.find(@product.supplier_account.supplier_id)
  	@product.destroy
  
  	respond_to do |format|
  			format.html { redirect_to administration_show_supplier_products_path(@supplier) }
  	end
  end
  
	# DELETE
  def destroy_supplier_service
    redirect_unless_privilege('Proveedores')
  	@service = Service.find params[:id]
  	@supplier = Supplier.find(@service.supplier_account.supplier_id)
  	@service.destroy
  
  	respond_to do |format|
  			format.html { redirect_to administration_show_supplier_services_path(@supplier) }
  	end
  end
  
  # REVIEWS
  # GET
  def reviews
    redirect_unless_privilege('Webpage')
  	@supplier_accounts = SupplierAccount.where(:country_id => session[:country].id)
  	@reviews = Review.order 'created_at DESC'
  end
  
  # GET
  def new_review
    redirect_unless_privilege('Webpage')
  	@supplier_account = SupplierAccount.find params[:id]
  	@review = @supplier_account.reviews.new
  	@review.build_star_rating
  end
    
  # GET
  def edit_review
    redirect_unless_privilege('Webpage')
  	@review = Review.find params[:id]
  	@supplier_account = SupplierAccount.find @review.reviewable_id
  end
  
  # PUT
  def update_review
    redirect_unless_privilege('Webpage')
  	@review = Review.find params[:id]
  	
  	respond_to do |format|
  		if @review.update_attributes(params[:review])
  			format.html { redirect_to administration_reviews_path}
  		end	
  	end
  end
  
  # DELETE
  def destroy_review
    redirect_unless_privilege('Webpage')
  	@review = Review.find params[:id]
  	
  	@review.destroy
  	respond_to do |format|
  		format.html {redirect_to administration_reviews_path}
  	end
  end

  def edit_dispatch_costs
    redirect_unless_privilege('Vestidos')
    
    @regions = []
    @regions << Region.find_by_name('RM - Metropolitana')
    @regions = @regions + Region.all
    @regions = @regions.uniq
  end

  def update_dispatch_costs
    redirect_unless_privilege('Vestidos')
    
    @communes = Commune.update(params[:communes].keys, params[:communes].values).reject { |commune| commune.errors.empty? }
    @regions = Region.update(params[:regions].keys, params[:regions].values).reject { |region| region.errors.empty? }
    
    if @communes.empty? and @regions.empty?
      redirect_to administration_edit_dispatch_costs_path
    else
      render :action => "edit_dispatch_costs"
    end
  end
  
end
