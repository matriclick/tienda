class ProductImagesController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier
	
  # GET /product_images
  # GET /product_images.json
  def index
    @product_images = ProductImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_images }
    end
  end

  # GET /product_images/1
  # GET /product_images/1.json
  def show
    @product_image = ProductImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_image }
    end
  end

  # GET /product_images/new
  # GET /product_images/new.json
  def new
		@supplier_account = @supplier.supplier_account
		@product = Product.find params[:product_id]
    @product_image = @product.product_images.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_image }
    end
  end

  # GET /product_images/1/edit
  def edit
		@supplier_account = @supplier.supplier_account
		@product = Product.find params[:product_id]
    @product_image = ProductImage.find(params[:id])
  end

  # POST /product_images
  # POST /product_images.json
  def create
		@product = Product.find params[:product_id]
    @product_image = ProductImage.new(params[:product_image])
		@product_image.product_id = @product.id

    respond_to do |format|
      if @product_image.save
        format.html { redirect_to edit_supplier_account_product_path(@supplier, @product), :notice => "#{t('activerecord.successful.messages.created', :model => @product_image.class.model_name.human)}" }
      else
        @supplier_account = @supplier.supplier_account
    		@product = Product.find params[:product_id]
        format.html { render action: "new" }
      end
    end
  end

  # PUT /product_images/1
  # PUT /product_images/1.json
  def update
		@product = Product.find params[:product_id]
    @product_image = ProductImage.find(params[:id])

    respond_to do |format|
      if @product_image.update_attributes(params[:product_image])
        format.html { redirect_to edit_supplier_account_product_path(@supplier, @product), :notice => "#{t('activerecord.successful.messages.updated', :model => @product_image.class.model_name.human)}" }
        format.json { head :ok }
      else
     		@supplier_account = @supplier.supplier_account
		    @product = Product.find params[:product_id]
        @product_image = ProductImage.find(params[:id])
        format.html { render action: "edit" }
        format.json { render json: @product_image.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_multiple
    @product = Product.find params[:product_id]

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to edit_supplier_account_product_url(@supplier, @product), :notice => "#{t('activerecord.successful.messages.updated', :model => @product.class.model_name.human)}" }
        format.json { head :ok }
      else
        @supplier_account = @supplier.supplier_account
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /product_images/1
  # DELETE /product_images/1.json
  def destroy
    @product_image = ProductImage.find(params[:id])
    @product_image.destroy

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
end
