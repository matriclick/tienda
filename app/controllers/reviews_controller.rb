class ReviewsController < ApplicationController
  before_filter :hide_left_menu
  
  def index 
		
		@supplier_account = SupplierAccount.find params[:id]
		@user = current_user
		
		@review = Review.new
		@review.build_star_rating
		
		respond_to do |format|
  		format.html {render :layout => false}
  	end
  	
	end

	# POST
	#REMOTE
	def create
		@review = Review.new params[:review]
		@review.user_id = current_user.id
	
	  respond_to do |format|
	    if @review.save
		
				# FGM: Update user account so later notificacion email won't be sent.
				current_user.user_account.update_attribute(:did_review, true)
	      format.html { redirect_to :back }
	      format.js
	    else
				format.js
			end
	  end
	end

	def check_env
		unless Rails.env == "development"
			redirect_to root_country_path
		end
	end

end
