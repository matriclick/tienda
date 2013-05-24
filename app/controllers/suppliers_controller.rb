class SuppliersController < ApplicationController
  before_filter :check_supplier
	before_filter :set_supplier_language
  private
  #This set the session language when a supplier is created
  
	def set_supplier_language
    if (user_signed_in? and !current_user.nil? and (current_user.role_id == 1))
      I18n.locale = Supplier.find(params[:supplier_id]).language if supplier_signed_in?
  	else  
      I18n.locale = current_supplier.language if supplier_signed_in?
  	end
  end
  
end
