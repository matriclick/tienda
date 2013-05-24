class BudgetsController < ApplicationController
  before_filter :authenticate_user!
	before_filter :load_default_budget_invitee_counts, :only => [:menu, :instructions, :premium, :standard, :econ]
	before_filter :load_budget_slots, :only => [:menu, :instructions, :premium, :standard, :econ]
	before_filter :authenticate_guest, :only => [:menu, :instructions, :premium, :standard, :econ]
	
  def instructions
		
    respond_to do |format|
      format.html
      format.js  { head :ok }
    end
  end
  
	def settings
		@budget_invitee_counts = current_user.user_account.budget_invitee_counts
		@budget_invitation_types = BudgetInvitationType.where('name not like "%total%"')
		@budget_distribution_types = BudgetDistributionType.all
		@budget_slots = current_user.user_account.budget_slots.by_type("$$")

    respond_to do |format|
      format.html
      format.js  { head :ok }
    end
	end

	def premium
		@type = "$$$"
		load_items_and_total_prices(@type)
	end

	def standard
		@type = "$$"
		load_items_and_total_prices(@type)
	end
	
	def econ
		@type = "$"
		load_items_and_total_prices(@type)
	end
	
	def new
		@type = params[:type]
		case @type
		when "econ"
			@type = "$"
		when "standard"
			@type = "$$"
		when "premium"
			@type = "$$$"
		end
		@custom_industry_category = IndustryCategory.find(params[:custom_industry_category_id]) if params[:custom_industry_category_id].present?
		@budget = Budget.new
		@budget.budget_type = BudgetType.find_by_name(@type)
		@budget.budget_slot = current_user.user_account.budget_slots.by_type(@type).where(:industry_category_id => @custom_industry_category.id).first
		
		respond_to do |format|
			format.html {render :layout => false}
		end
	end
	
	def create
		@budget = Budget.create!(params[:budget].merge(user_account_id: current_user.user_account.id))
		redirect_to :back
	end
	
	def edit
		@budget = Budget.find params[:id]
		
		respond_to do |format|
			format.html { render :layout => false }
		end
	end
	
	def update
		@budget = Budget.find params[:id]
		
		respond_to do |format|
			if @budget.update_attributes! params[:budget]
				format.html { redirect_to :back }
			end
		end
	end
	
  def destroy
		@budget = Budget.find params[:id]
    @budget.destroy

		respond_to do |format|
      format.html { redirect_to :back }
			format.js
		end
  end

	def menu
		@user_account = current_user.user_account
		@budget = @user_account.tentative_budget.budget_range.range unless @user_account.tentative_budget.nil? 
		@expenses = @user_account.get_expenses_total_price
	end
	
	def update_budget_config
		if params[:budget_invitee_counts]
			@budget_invite_counts = params[:budget_invitee_counts]
			@budget_invite_counts.each do |k,v|
				BudgetInviteeCount.find(k).update_attributes(v)
			end
		end
		
		if params[:user_account]
			current_user.user_account.update_attribute(:budget_distribution_type_id, params[:user_account][:budget_distribution_type_id] == 'on' ? nil : params[:user_account][:budget_distribution_type_id])
			
			if params[:user_account][:budget_distribution_type_id] == 'on'
				unless params[:budget_slots].blank?
					params[:budget_slots].each do |id, dti|
						BudgetSlot.find(id).update_attribute(:budget_distribution_type_id, dti[:budget_distribution_type_id])
					end
				end
			else
				current_user.user_account.budget_slots.each { |bs| bs.update_attribute(:budget_distribution_type_id, params[:user_account][:budget_distribution_type_id]) }
			end
		end

		redirect_to :back
	end
	
	private
	def load_items_and_total_prices(type)
		@budget_slots = current_user.user_account.budget_slots.by_type(@type).prioritized
		@budget_invitee_counts = current_user.user_account.budget_invitee_counts
		total_prices(type)
	end
	
	def total_prices(type)
		@total_top_price_range = current_user.user_account.get_budget_total_top_price_range_by_type(type: type)
		@total_price = current_user.user_account.get_budget_total_price_by_type(type: type)
	end
	
	def load_default_budget_invitee_counts
		if user_signed_in?
			if current_user.user_account.budget_invitee_counts.blank?
				BudgetInvitationType.party_and_dinner.each do |bit|
					BudgetInviteeCount.create!(user_account_id: current_user.user_account_id, budget_invitation_type_id: bit.id)
				end
			end
		end
	end
	
  def redirect_if_guest
  	if current_user.role_id == 3 
  		redirect_to :action => :instructions
  	end
  end
end
