class PasswordsController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier, :except => :new

  def edit
  end

	def new
	end

  def update
		if @supplier.update_with_password(params[:supplier])
      sign_in(@supplier, :bypass => true)
      redirect_to supplier_home_path, :notice => "#{t('activerecord.successful.messages.updated', :model =>  @supplier.class.model_name.human)}"
    else
      render :edit
    end
  end
end
