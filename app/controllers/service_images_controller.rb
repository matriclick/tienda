class ServiceImagesController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier

  def index
    @service_images = ServiceImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @service_images }
    end
  end

  def show
    @service_image = ServiceImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service_image }
    end
  end

  def new
		@supplier_account = @supplier.supplier_account
		@service = Service.find params[:service_id]
    @service_image = @service.service_images.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service_image }
    end
  end

  def edit
		@supplier_account = @supplier.supplier_account
		@service = Service.find params[:service_id]
    @service_image = ServiceImage.find(params[:id])
  end

  def create
    @service = Service.find params[:service_id]
    @service_image = ServiceImage.new(params[:service_image])
		@service_image.service_id = @service.id
        
    respond_to do |format|
      if @service_image.save
        format.html { redirect_to edit_supplier_account_service_path(@supplier, @service), :notice => "#{t('activerecord.successful.messages.created', :model =>  @service_image.class.model_name.human)}"  }
      else
		    @supplier_account = @supplier.supplier_account
    		@service = Service.find params[:service_id]
        format.html { render "new" }
      end
    end
  end

  def update
 		@service = Service.find params[:service_id]
    @service_image = ServiceImage.find(params[:id])

    respond_to do |format|
      if @service_image.update_attributes(params[:service_image])
                format.html { redirect_to edit_supplier_account_service_path(@supplier, @service), :notice => "#{t('activerecord.successful.messages.updated', :model =>  @service_image.class.model_name.human)}"  }
        format.json { head :ok }
      else
    		@supplier_account = @supplier.supplier_account
		    @service = Service.find params[:service_id]
        @service_image = ServiceImage.find(params[:id])
        format.html { render action: "edit" }
        format.json { render json: @service_image.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #DZF this is the update_service_images from services_controller, moving to fix the error render
	def update_multiple
    @service = Service.find params[:service_id]

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to edit_supplier_account_service_url(@supplier, @service), :notice => "#{t('activerecord.successful.messages.updated', :model => @service.class.model_name.human)}" }
      else
        @supplier_account = @supplier.supplier_account
        format.html { render 'new' }
        format.json { render json: @service_image.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @service_image = ServiceImage.find(params[:id])
    @service_image.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end
end
