class ReferenceRequestsController < ApplicationController
	
	#POST
	def ask_reference
		@object = eval(params[:object_class]).find params[:id] if params[:object_class]
		@reference_request = ReferenceRequest.new params[:reference_request]
		@reference_request.user_id = current_user.id
		
		if @object.class.to_s == "Product"
			@reference_request.product_id = params[:id]
		elsif @object.class.to_s == "Service"
			@reference_request.service_id = params[:id]
		elsif params[:supplier_id]
			@object = Supplier.find params[:supplier_id]
			@reference_request.supplier_id = params[:supplier_id]
		end
		@reference_request.supplier_account_id = @object.supplier_account.id
		
		respond_to do |format|
			if @reference_request.save
				unless @object.kind_of? Supplier
					format.html{ redirect_to products_and_services_catalog_description_url(@object, :fancy_successful => true, :object_class => @object.class)}
				else
					format.html{ redirect_to supplier_description_url(@object.supplier_account.public_url, @object, :fancy_successful => true)}
				end
			end
		end
		
	end
	
end
