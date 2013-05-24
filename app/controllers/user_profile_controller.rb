class UserProfileController < ApplicationController
  before_filter :load_user_account
  before_filter :authenticate_user!
  before_filter :authenticate_guest, :only => [:show]
  before_filter :redirect_if_guest, :except => [:show, :sign_in_user]
	
  def show
		@enable_campaign = true
		
		@user = current_user
		
		#DZF this is for users without user_account
		if @user.user_account.nil?
		  ua = UserAccount.new
		  ua.save :validate => false
		  
		  @user.user_account_id = ua.id
	  	@user.save :validate => false
		end
		@user_account = @user.user_account
		
		@budget_ranges = BudgetRange.all
		@groom = @user_account.groom || Groom.new
		@bride = @user_account.bride || Bride.new
		
  	@all_users = current_user.user_account.users
  	@users = []
  	
  	@all_users.each do |user|
  		@users << user 
  	end
  	@profile_average = @user_account.get_profile_average  	
  end

  def edit
  	@user = current_user
  	@user_account = @user.user_account
    puts '--------------------'
    puts @user_account
    puts '--------------------'
    
		@user_account.ensure_groom_bride_exists
		
  	@budget_ranges = BudgetRange.all
	  #build nested attributes
		@user_account.groom.build_address if @user_account.groom.address.blank?
		@user_account.groom.build_groom_image if @user_account.groom.groom_image.blank?
		
		@user_account.bride.build_address if @user_account.bride.address.blank?
		@user_account.bride.build_bride_image if @user_account.bride.bride_image.blank?
		
		@user_account.build_tentative_budget if @user_account.tentative_budget.blank?
		@user_account.build_user_account_image if @user_account.user_account_image.blank?
		
		@user_account.build_campaign_user_account_info if @user_account.campaign_user_account_info.blank?
		
		@user_account.user_account_trading_house.build if @user_account.user_account_trading_house.blank?
		
		@trading_houses = TradingHouse.all
		@trading_houses << TradingHouse.new( :attributes => {:name => t("other")})
		@trading_houses << TradingHouse.new( :attributes => {:name => t("without_trading_house")})
  end
  
	def update
		@user = @user_account.users.where(:is_owner => true).first
		old_date =  @user_account.wedding_tentative_date
		@budget_ranges = BudgetRange.all
		
		respond_to do |format|
			if @user_account.update_attributes params[:user_account]
				
				if old_date != @user_account.wedding_tentative_date #DZF update matrichecklist's dates logic
					unless @user_account.activities.blank?
						@user_account.activities.each do |activity|
							activity.update_done_by_date
						end	
					end
				end
				
				format.html { redirect_to user_profile_url, notice: "#{t('activerecord.successful.messages.updated', :model =>  @user_account.class.model_name.human)}" }
			else
				@enable_campaign = true

				@trading_houses = TradingHouse.all
				@trading_houses << TradingHouse.new( :attributes => {:name => t("other")})
				@trading_houses << TradingHouse.new( :attributes => {:name => t("without_trading_house")})
				@budget_ranges = BudgetRange.all
				format.html { render 'edit' }
			end
		end
	end
  
  def add_user
		@user = User.new
  end
  
  def create_user
    generated_password = Devise.friendly_token.first(6)
		@user = User.new(:email => params[:user][:email], 
			:password => generated_password, 
			:password_confirmation => generated_password)
    @user.user_account_id = current_user.user_account_id

    respond_to do |format|
		  if @user.save	
				UserMailer.user_email(@user, generated_password).deliver			
			  format.html { redirect_to user_profile_url, :notice => "#{t('activerecord.successful.messages.created', :model =>  @user.class.model_name.human)}"  }
			  format.json { head :ok }
		  else
			  format.html { render action: 'add_user' }
			  format.json { render json: @user.errors, status: :unprocessable_entity }
  	  end
    end
  end
  
  def destroy_user
  	@user = User.find params[:id]
  	@user.destroy
  	
  	respond_to do |format|
		  format.html { redirect_to user_profile_url }
		  format.json { head :ok }
  	end
  end
  
  def redirect_if_guest
  	if current_user.role_id == 3 
  		redirect_to :action => :show
  	end
  end
  
  # DESTROY
  def sign_in_user #DZF destroy current_session and redirect to sign_up form
  	Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
  	redirect_to new_user_registration_url
  end
end
