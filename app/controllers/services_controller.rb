class ServicesController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier
  
	def index
    @services = @supplier.supplier_account.services.order(:place)
    @sellsservices = ((@supplier.supplier_account.industry_categories.find_all_by_industry_category_type_id(2).length!=0) || (@supplier.supplier_account.industry_categories.find_all_by_industry_category_type_id(3).length!=0))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @services }
    end
  end

  def show
    @show_map = true;
    @service = Service.find params[:id]
    #@rent_type = RentType.find @service.rent_type_id
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end

  def new
 		@supplier_account = @supplier.supplier_account
 		#TCT: Obtaining all the not deliverable ids for services javascript which shows or not the address fields depending if service is deliverable
 		@not_deliverable_services_ids = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).where(industry_category_type_id:2).map(&:id) 
    @service = @supplier.supplier_account.services.build
    @color_types = ColorType.all
		@industry_categories = @supplier_account.industry_categories.where("industry_category_type_id = 3 OR industry_category_type_id = 2") # if @supplier_account.industry_categories.where("industry_category_type_id = 1 OR industry_category_type_id = 2").count > 1

		#DZF here I make the dynamic grouped_options_for_select options
		@industry_cat_types = @industry_categories.inject({}) do |options, industry_category|
		  (options[industry_category.industry_category_type.name] ||= []) << [industry_category.get_name, industry_category.id]
  		options
		end
    service_faqs = @service.service_faqs.build
    @service.videos.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  def edit
  	@supplier_account = @supplier.supplier_account
    @service = Service.find params[:id]
    #TCT: Obtaining all the not deliverable ids for services javascript which shows or not the address fields depending if service is deliverable
    @not_deliverable_services_ids = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).where(industry_category_type_id:2).map(&:id) 
    @color_types = ColorType.all
		@industry_categories = @supplier_account.industry_categories.where("industry_category_type_id = 3 OR industry_category_type_id = 2") #if @supplier_account.industry_categories.where("industry_category_type_id = 1 OR industry_category_type_id = 2").count > 1
		@service.videos.build if @service.videos.blank?
		#DZF here I make the dynamic grouped_options_for_select options
		@industry_cat_types = @industry_categories.inject({}) do |options, industry_category|
		  (options[industry_category.industry_category_type.name] ||= []) << [industry_category.get_name, industry_category.id]
  		options
		end
    service_faqs = @service.service_faqs.build
  end

  def create
  	@supplier_account = @supplier.supplier_account
    @service = Service.new(params[:service])
   
    respond_to do |format|
      if @service.save
				@supplier.supplier_account.services << @service
        format.html { redirect_to supplier_account_services_url(@supplier), :notice => "#{t('activerecord.successful.messages.created', :model => @service.class.model_name.human)}" }
        format.json { render json: @service, status: :created, location: @service }
      else
				@service.supplier_account_id = @supplier_account.id
				@industry_categories = @supplier_account.industry_categories.where("industry_category_type_id = 3 OR industry_category_type_id = 2") # if @supplier_account.industry_categories.where("industry_category_type_id = 1 OR industry_category_type_id = 2").count > 1
				@industry_category_types = IndustryCategoryType.where("id = 2 OR id = 3")
				@industry_cat_types = @industry_categories.inject({}) do |options, industry_category|
				  (options[industry_category.industry_category_type.name] ||= []) << [industry_category.get_name, industry_category.id]
		  		options
		  	end
		  	@not_deliverable_services_ids = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).where(industry_category_type_id:2).map(&:id)
     		@color_types = ColorType.all
        format.html { render action: "new" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  	@supplier_account = @supplier.supplier_account
    @service = Service.find params[:id]
    @service.industry_category_id = params[:industry_category] # DZF had to set the value here 'cause the weird select
#    @service.industry_category_id = @supplier_account.industry_categories.where(:industry_category_type_id => 2).first.id if @supplier_account.industry_categories.where(:industry_category_type_id => 2).count == 1
            
    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to supplier_account_services_url(@supplier), :notice => "#{t('activerecord.successful.messages.updated', :model =>  @service.class.model_name.human)}"  }
        format.json { head :ok }
      else
				@industry_categories = @supplier_account.industry_categories.where("industry_category_type_id = 3 OR industry_category_type_id = 2") # if @supplier_account.industry_categories.where("industry_category_type_id = 1 OR industry_category_type_id = 2").count > 1
				@industry_category_types = IndustryCategoryType.where("id = 2 OR id = 3")
				@industry_cat_types = @industry_categories.inject({}) do |options, industry_category|
				  (options[industry_category.industry_category_type.name] ||= []) << [industry_category.get_name, industry_category.id]
		  		options
		  	end
		  	@not_deliverable_services_ids = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).where(industry_category_type_id:2).map(&:id) 
		  	@color_types = ColorType.all
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @service = @supplier.supplier_account.services.find params[:id]
    @service.destroy

    respond_to do |format|
      format.html { redirect_to supplier_account_services_url(@supplier) }
      format.json { head :ok }
    end
  end
end
