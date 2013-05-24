class ConversationsController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier, :except => [:create, :create_by_service, :create_message]

#Actions related to supplier's conversations
	def index
		@all_conversations = @supplier.supplier_account.conversations.sort! {|a,b| b.created_at <=> a.created_at }
	end
	
	def show
		@conversation = Conversation.find params[:id]
		@conversable = @conversation.conversable
		@transmitter = @supplier.supplier_account.corporate_name
		@message = Message.new
		@conversation.messages.each do |message|
			message.update_attributes(:supplier_read => true)
		end
	end

#end of supplier actions

	def create #DZF This is supporting 3 kinds of views: products_catalog, services_catalog $ products_and_services_catalog
	    
		@conversation = Conversation.new params[:conversation]
		@conversation.user_id = current_user.id
		@conversation.conversable = @object = eval(params[:object_class]).find(params[:id])
		@conversation.supplier_account_id = @object.supplier_account_id
		@supplier = @object.supplier_account.supplier
		
		#if !@conversation.messages.nil? ?	@conversation.messages.first.transmitter = params[:transmitter] : redirect_to products_and_services_catalog_conversations_url(@object, :object_class => @object.class)		
		@conversation.messages.first.transmitter = params[:transmitter] 
		
		if @conversation.save
			respond_to do |format|
				format.html{ redirect_to products_and_services_catalog_conversations_url(@object, :object_class => @object.class)}
				format.js
			end
		end
	end
	
	def create_message #DZF supporting 3 views like create_conversations
		@object_name = params[:object_name] if params[:object_name]
		@message = Message.new params[:message]
		@message.conversation_id = params[:conversation_id]
		@message.transmitter = params[:transmitter]
		if supplier_signed_in?
			@message.is_supplier = true
			@message.user_read = false
			@message.supplier_read = true
		else
			@message.is_supplier = false
			@message.user_read = true
			@message.supplier_read = false
		end
		
		if @message.save
			respond_to do |format|
				format.html { redirect_to :back }
			end
		end
	end
	
	# GET
  def download_file
  	@attached_file = AttachedFile.find params[:attached_file]
  	send_file @attached_file.attached.path, :type => @attached_file.attached_content_type, :filename => @attached_file.attached_file_name
  end
end
