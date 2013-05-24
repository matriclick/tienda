class PresentationsController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier

  def show
		@presentation = @supplier.supplier_account.presentation
  end

  def edit
		@presentation = @supplier.supplier_account.presentation
  end

  def create
		@presentation = @supplier.supplier_account.build_presentation params[:presentation]
		
		respond_to do |format|
      if @presentation.save
        format.html { redirect_to supplier_account_presentation_path(@supplier), :notice => "#{t('activerecord.successful.messages.created', :model => @presentation.class.model_name.human)}" }
      else
        format.html { render :new }
      end
    end
  end

  def new
		@presentation = @supplier.supplier_account.build_presentation
  end

  def update
		@presentation = @supplier.supplier_account.presentation
		
		respond_to do |format|
			if @presentation.update_attributes(params[:presentation])
        format.html { redirect_to supplier_account_presentation_path(@supplier), :notice => "#{t('activerecord.successful.messages.updated', :model => @presentation.class.model_name.human)}" }
			else
				format.html { render :edit }
			end	
		end
  end
end
