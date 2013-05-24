class UserConversationsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authenticate_guest, :only => [:index]
  def index
  	@user = current_user
		@conversations = @user.conversations.sort {|a,b| b.created_at <=> a.created_at }
		@purchases = @user.purchases.where(:status => 'finalizado')
  end
end
