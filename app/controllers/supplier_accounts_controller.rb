class SupplierAccountsController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier
	load_and_authorize_resource
	
	def show
		@unread_bookings = true if @supplier.supplier_account.unread_bookings?
		@supplier_account = @supplier.supplier_account
	end
	
  def edit
		@industry_categories = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).order "name"
		
    @industry_category_types = IndustryCategoryType.all
		@supplier_account = @supplier.supplier_account
  end

  def update
		@supplier_account = @supplier.supplier_account
	
	# FGM: Set language without updating supplier_account attributes
		if params[:set_language]
      @supplier.update_attributes :language => params[:set_language]
      I18n.locale = @supplier.language
			redirect_to :back
			
			# FGM: Break update method.
			return
    end
  # DZF: Set Supplier approvation to true when supplier click in the preview link_to  
    if params[:validate_account]
      @supplier_account.update_attribute :approved_by_supplier, true
      redirect_to :back
      return
    end

		@aux = @supplier_account.industry_category_ids
		#DZF this is saving even when a supplier don't have any industry_category
		@supplier_account.industry_category_ids = params[:supplier_account][:industry_category_ids] ||= []

		respond_to do |format|
			if @supplier_account.update_attributes params[:supplier_account]
        format.html { redirect_to supplier_account_path(@supplier), :notice => "#{t('activerecord.successful.messages.updated', :model => @supplier_account.class.model_name.human)}" }
			else
			  @supplier_account = @supplier.supplier_account
        @industry_category_types = IndustryCategoryType.all
			  #saving back the industry_categories
			  @supplier_account.industry_category_ids = @aux
			  # Changed IndustryCategories to IndustryCategory DZF
				@industry_categories = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).order "name"
				format.html { render "edit" }
			end
		end
  end
  
  def calendar
		  @supplier = Supplier.find params[:supplier_id]
  		@presentation = @supplier.supplier_account.presentation
  		@reserved_dates = @supplier.supplier_account.reserved_dates
  		@date_selector = params[:year] ? Date.parse(params[:year]) : Date.today
  end

end