class Budget < ActiveRecord::Base
	belongs_to :user_account
	belongs_to :budgetable, :polymorphic => true
	belongs_to :budget_type
	belongs_to :supplier_account
	belongs_to :industry_category
	belongs_to :budget_invitation_type
	belongs_to :budget_slot
	
	validate :industry_category_id_is_better_than_industry_category_name
	validate :supplier_account_id_is_better_than_supplier_account_fantasy_name
	
	def self.by_type(name)
		joins(:budget_type).where('budget_types.name = ?', name)
	end
	
	def self.by_invitation_type(name)
		joins(:budget_invitation_type).where('budget_invitation_types.name = ?', name)
	end

	def final_price
		if price.present? and price != 0
			return price
		elsif budgetable.present?
			if budgetable.top_price_range > 0
				return { base: budgetable.price, top: budgetable.top_price_range }				
			else
				return budgetable.price
			end
		else
			nil
		end
	end

	def industry_category_id_is_better_than_industry_category_name
		self.industry_category_name = nil if industry_category_id.present?
	end
	
	def supplier_account_id_is_better_than_supplier_account_fantasy_name
		self.supplier_account_fantasy_name = nil if supplier_account_id.present?
	end
end
