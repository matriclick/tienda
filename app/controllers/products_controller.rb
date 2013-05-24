class ProductsController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier
	
  def index
		@supplier = Supplier.find params[:supplier_id]
    @products = @supplier.supplier_account.products.order(:place)
    @sellsproducts = (@supplier.supplier_account.industry_categories.find_all_by_industry_category_type_id(1).length!=0)
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def new
		@supplier_account = @supplier.supplier_account
    @product = @supplier.supplier_account.products.build

		#DZF When Supplier has just one IndustryCategory, don't ask for it		#adding where to search for products (icti => 1) industry categories
		@industry_categories = @supplier_account.industry_categories.where(:industry_category_type_id => 1) if @supplier_account.industry_categories.where(:industry_category_type_id => 1).count > 1
    product_faqs = @product.product_faqs.build
    @product.videos.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  def edit
	  @supplier_account = @supplier.supplier_account
    @product = Product.find params[:id]
		@product_types = ProductType.of_supplier @supplier
		@product.videos.build if @product.videos.blank?
		#DZF When Supplier has just one IndustryCategory, don't ask for it		
		@industry_categories = @supplier_account.industry_categories.where(:industry_category_type_id => 1) if @supplier_account.industry_categories.where(:industry_category_type_id => 1).count > 1
    product_faqs = @product.product_faqs.build
  end

  def create
  	@supplier_account = @supplier.supplier_account
    @product = Product.new (params[:product])
    @product.industry_category_id = @supplier_account.industry_categories.where(:industry_category_type_id => 1).first.id if @supplier_account.industry_categories.where(:industry_category_type_id => 1).count == 1

    respond_to do |format|
      if @product.save
				@supplier.supplier_account.products << @product
        format.html { redirect_to supplier_account_products_url(@supplier), :notice => "#{t('activerecord.successful.messages.created', :model => @product.class.model_name.human)}" }
      else
        @supplier_account = @supplier.supplier_account
        @product = @supplier.supplier_account.products.build
				@industry_categories = @supplier_account.industry_categories.where(:industry_category_type_id => 1) if @supplier_account.industry_categories.where(:industry_category_type_id => 1).count > 1
        format.html { render action: "new" }
      end
    end
  end

  def update
  	@supplier_account = @supplier.supplier_account
    @product = Product.find params[:id]
    if (@supplier_account.industry_categories.where(:industry_category_type_id => 1).count == 1 && @supplier_account.industry_categories.where(:industry_category_type_id => 1).first.id == @product.industry_category_id) or @product.industry_category_id.blank?
	    @product.industry_category_id = @supplier_account.industry_categories.first.id
	  end
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to supplier_account_products_url(@supplier), :notice => "#{t('activerecord.successful.messages.updated', :model => @product.class.model_name.human)}" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy

    respond_to do |format|
      format.html { redirect_to supplier_account_products_url(@supplier) }
      format.json { head :ok }
    end
  end
end
