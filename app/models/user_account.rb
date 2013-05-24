class UserAccount < ActiveRecord::Base
  include CountryMethods

  after_create :set_country_id_with_locale
	after_create :ensure_groom_bride_exists

	has_one :groom, :dependent => :destroy
	has_one :bride, :dependent => :destroy
	has_one :user_account_image, :dependent => :destroy
	has_one :tentative_budget, :dependent => :destroy
	has_one :campaign_user_account_info, :dependent => :destroy
	has_one :invitation, :dependent => :destroy
  belongs_to :country
	belongs_to :budget_distribution_type
	belongs_to :country
	has_many :users, :dependent => :destroy
	has_many :invitee_groups, :dependent => :destroy
	has_many :invitees, :dependent => :destroy
	has_many :people, :dependent => :destroy
	has_many :product_budgets, :dependent => :destroy
	has_many :service_budgets, :dependent => :destroy
	has_many :budgets, :dependent => :destroy
	has_many :budget_slots, :dependent => :destroy
	has_many :expenses, :dependent => :destroy
	has_many :products, :through => :budgets
	has_many :activities, :dependent => :destroy
	has_many :events
	has_many :budget_invitee_counts, :dependent => :destroy
	has_many :user_account_trading_house
	has_many :trading_houses, :through => :user_account_trading_house
	has_many :bookings, :dependent => :destroy
	
	accepts_nested_attributes_for :groom, :bride, :tentative_budget, :user_account_trading_house, :campaign_user_account_info
	accepts_nested_attributes_for :user_account_image, :reject_if => proc { |a| a[:couple].blank? }, :allow_destroy => true  
	
	#validations
#  validates :tentative_budget, :presence => true
#  validates :invitees_quantity, :presence => true
#  validates :wedding_tentative_date, :presence => true
#  validates :wedding_city, :presence => true

  def assign_default_activities
    DefaultActivity.all.each do |act|
      Activity.create(:user_account_id => self.id , :default_activity_id => act.id)
    end
  end

	def assign_default_invitee_groups
		DefaultInviteeGroup.all.each do |dig|
			InviteeGroup.create(:user_account_id => self.id, :name => dig.name)
		end
	end
  
  def get_wedding_name
  	if self.groom.blank?
  		if self.bride.blank?
  			return('Usuario '+ self.users.first.email.to_s)
  		else
  			unless self.bride.lastname_p.blank? #mensaje de novia
  				return('Novia '+self.bride.lastname_p.to_s)
	 			else
 					return('Usuario '+self.users.first.email.to_s)
  			end
  		end
  	elsif self.bride.blank?
  		unless self.groom.lastname_p.blank? #mensaje de novio
  			return('Novio '+self.groom.lastname_p.to_s)
 			else
 				return('Usuario '+self.users.first.email.to_s)
  		end
  	else
 			if self.groom.lastname_p.blank?
				if self.bride.lastname_p.blank?
					return('Usuario '+self.users.first.email.to_s)
				else
					return('Novia '+self.bride.lastname_p.to_s)
				end
			elsif self.bride.lastname_p.blank?		
				return('Novio '+self.groom.lastname_p.to_s)
			else
				return('Matrimonio '+self.groom.lastname_p.to_s+' y '+ self.bride.lastname_p.to_s)	
  		end
  	end
  end
  
	def included_in_budget?(object, budget_type)
		budgets.where(:budget_type_id => budget_type, :budgetable_type => object.class, :budgetable_id => object.id).present?
	end
	
	def related_budget(object, budget_type)
		budgets.where(:budget_type_id => budget_type, :budgetable_type => object.class, :budgetable_id => object.id).first
	end

  def get_wedding_first_name
		return 'Matrimonio '+self.groom.name.to_s+' y '+ self.bride.name.to_s unless (self.groom.blank? or self.bride.blank?)
  end
  
  def get_wedding_lastname
		return 'Matrimonio '+self.groom.lastname_p.to_s+' y '+ self.bride.lastname_p.to_s unless (self.groom.blank? or self.bride.blank?)
  end

	def communes
		communes = []
		self.groom.present? ? self.groom.address.present? ? self.groom.address.commune.present? ? communes << self.groom.address.commune.name : nil : nil : nil
		self.bride.present? ? self.bride.address.present? ? self.bride.address.commune.present? ? communes << self.bride.address.commune.name : nil : nil : nil
		communes
	end
  
  def has_enough_info
  	if self.bride.blank?
  	  return false
    else
	    return false unless self.bride.check_data
    end
    if self.groom.blank?
	    return false
    else
    	 return false unless self.groom.check_data
    end
    return false if (self.groom.email.blank? and self.bride.email.blank?)
    return false if self.wedding_tentative_date.blank?
    
    return true
  end
  
  def get_expenses_total_price
  	expenses_total_price = 0
  	self.expenses.each do |expense|
  		expenses_total_price += expense.total_price
  	end
  	return expenses_total_price
  end
  
  def get_expenses_total_total_payed_price
  	expenses_total_payed_price = 0
  	self.expenses.each do |expense|
  		expenses_total_payed_price += expense.payed_price
  	end
  	return expenses_total_payed_price
  end
  
  def get_expenses_total_remaining_price
  	expenses_total_remaining_price = 0
  	self.expenses.each do |expense|
  		expenses_total_remaining_price += expense.remaining_price
  	end
  	return expenses_total_remaining_price
  end
  
  def get_payer_total_price_by_id(id)
  	payers = Payer.where(:payer_type_id => id).where("expense_id in (?)", self.expense_ids)
  	total_price = 0
  	payers.each do |p|
  		total_price += ((p.expense.price * p.expense.quantity ) * p.percentage.to_i) / 100
  	end
  	return total_price
  end
  
  def get_profile_average
  #DZF count each field not blank
  #groom and bride 10 each, user_account 5. TOTAL = 25
  	total = 0
  	count = 0
  	self.attributes.each do |attr|
  		unless attr.first  == "receive_news" || attr.first  == "receive_supplier_promotions" || attr.first  == "show_my_phones"
				total += 1
				count += 1 unless attr.last.blank?
			end
  	end
  	
  	unless self.groom.blank?
			self.groom.attributes.each do |attr|
				total += 1
				count += 1 unless attr.last.blank?
			end
  	end
  	unless self.bride.blank?
			self.bride.attributes.each do |attr|
				total += 1
				count += 1 unless attr.last.blank?
			end
  	end

  	count = count * 100 / total
  	return count
  end
  
	def get_budget_part(budget_invitee_count_param, budget_type_name)
		part = 0
		self.budget_slots.by_type(budget_type_name).each { |bs| part += bs.budgets_total(budget_invitee_count_param) }
		part
	end

	def get_budget_total_price_by_type(options)
		items = budgets.by_type(options[:type])
		items = items.by_invitation_type(options[:invitation_type]) unless options[:invitation_type].blank?
		items += budgets.by_type(options[:type]).where(budget_invitation_type_id: nil) if options[:invitation_type].present? && options[:invitation_type].downcase.include?("total")
		price = 0

		items.each do |item|
			if item.budget_invitation_type.present?
				unless item.budget_invitation_type.name.downcase.include?("total") || options[:invitation_type].present?
					count = self.budget_invitee_counts.where(budget_invitation_type_id: item.budget_invitation_type_id).first.total_count
					price += ( item.price.present? ? item.price : item.budgetable.present? ? item.budgetable.price : 0 ) * count
				else
					price += ( item.price.present? ? item.price : item.budgetable.present? ? item.budgetable.price : 0 )
				end
			else
				price += ( item.price.present? ? item.price : item.budgetable.present? ? item.budgetable.price : 0 )
			end
		end
		price
	end
	
	def get_budget_total_top_price_range_by_type(options)
		items = budgets.by_type(options[:type])
		items = items.by_invitation_type(options[:invitation_type]) unless options[:invitation_type].blank?
		items += budgets.by_type(options[:type]).where(budget_invitation_type_id: nil) if options[:invitation_type].present? && options[:invitation_type].downcase.include?("total")
		price = 0
		
		items.each do |item|
			if item.budget_invitation_type.present?				
				unless item.budget_invitation_type.name.downcase.include?("total") || options[:invitation_type].present?
					count = self.budget_invitee_counts.where(budget_invitation_type_id: item.budget_invitation_type_id).first.total_count
					price += (item.price.present? ? item.price : item.budgetable.present? ? item.budgetable.top_price_range == 0 ? item.budgetable.price : item.budgetable.top_price_range : 0) * count					
				else
					price += (item.price.present? ? item.price : item.budgetable.present? ? item.budgetable.top_price_range == 0 ? item.budgetable.price : item.budgetable.top_price_range : 0)
				end
			else
				price += (item.price.present? ? item.price : item.budgetable.present? ? item.budgetable.top_price_range == 0 ? item.budgetable.price : item.budgetable.top_price_range : 0)
			end
		end
		price
	end
	
	def budget_total_price_by_invitation_and_budget_type_names(bic, type)
		# FGM: Sum of budgets with corresponding budget_invitation_type
		total = 0.5 * ( get_budget_total_price_by_type(type: type, invitation_type: bic.budget_invitation_type.name) + get_budget_total_top_price_range_by_type(type: type, invitation_type: bic.budget_invitation_type.name) )
		
		# FGM: Sum of budgets with budget_invitation_type = "Valor total" divided by total invitees
		total += 0.5 * (get_budget_total_price_by_type(type: type, invitation_type: "Valor Total") + get_budget_total_top_price_range_by_type(type: type, invitation_type: "Valor Total")) / budget_invitee_count_totals.to_f
	end
	
	def budget_invitee_count_totals
		budget_invitee_counts.sum(:groom) + budget_invitee_counts.sum(:bride) + budget_invitee_counts.sum(:g_parents) + budget_invitee_counts.sum(:b_parents)
	end

	def ensure_groom_bride_exists
		if groom.blank?
			self.build_groom
		end
		if bride.blank?
			self.build_bride
		end
		self.save :validate => false
	end	
end
