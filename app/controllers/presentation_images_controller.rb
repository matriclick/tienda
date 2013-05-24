# encoding: UTF-8
class PresentationImagesController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier
	
	def new
		@presentation_image = @supplier.supplier_account.presentation.presentation_images.build
		
		respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @presentation_image }
    end
	end
	
	def create
		@presentation_image = PresentationImage.new params[:presentation_image]
		
		respond_to do |format|
			if @presentation_image.save
				@supplier.supplier_account.presentation.presentation_images << @presentation_image
        format.html { redirect_to supplier_account_presentation_path(@supplier), :notice => "#{t('activerecord.successful.messages.created', :model => @presentation_image.class.model_name.human)}" }
	    else
	      format.html { render "new" }
	    end	
		end
	end
	
  def edit
		@presentation_image = PresentationImage.find params[:id]
  end

  def update
		@presentation_image = PresentationImage.find params[:id]
		
		respond_to do |format|
			if @presentation_image.update_attributes params[:presentation_image]
        format.html { redirect_to supplier_account_presentation_path(@supplier), :notice => "#{t('activerecord.successful.messages.updated', :model => @presentation_image.class.model_name.human)}" }
			else
				format.html { render "edit"}
			end
		end
  end

  def destroy
		@presentation_image = PresentationImage.find params[:id]
		@presentation_image.destroy
		respond_to do |format|
       format.html { redirect_to	supplier_account_presentation_path(@supplier) }
    end
  end
end
