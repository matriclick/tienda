class BudgetSlot < ActiveRecord::Base
	belongs_to :industry_category
	belongs_to :budget_distribution_type
	has_many :budgets
	belongs_to :user_account
	belongs_to :budget_type
	
	def self.by_type(name)
		joins(:budget_type).where('budget_types.name = ?', name)
	end
	
	def self.prioritized
		joins(:industry_category).order(:budget_priority)
	end
	
	def budgets_total(budget_invitee_count_param)
		total = 0
		if budget_distribution_type.name.downcase.include? "equitativo"
			total = budgets_sub_total(0.25)
		elsif budget_distribution_type.name.downcase.include? "prorrateo"
			ponderator = self.user_account.budget_invitee_counts.sum(budget_invitee_count_param.to_sym).to_f / self.user_account.budget_invitee_count_totals.to_f
			total = budgets_sub_total(ponderator)
		end
		total
	end
	
	def budgets_sub_total(ponderator)
		sub_total = 0
		
		budgets.each do |budget|
			average = budget.budgetable.present? ? budget.budgetable.top_price_range > 0 ? 0.5 : 1 : 1
			
			if budget.budget_invitation_type.present?
				unless budget.budget_invitation_type.name.downcase.include?("total")
					count = user_account.budget_invitee_counts.where(budget_invitation_type_id: budget.budget_invitation_type_id).first.total_count
					sub_total += ( budget.price.present? ? budget.price : budget.budgetable.present? ? (budget.budgetable.price + budget.budgetable.top_price_range) * average : 0 ) * count * ponderator
				else
					sub_total += ( budget.price.present? ? budget.price : budget.budgetable.present? ? (budget.budgetable.price + budget.budgetable.top_price_range) * average : 0 ) * ponderator
				end
			else
				sub_total += ( budget.price.present? ? budget.price : budget.budgetable.present? ? (budget.budgetable.price + budget.budgetable.top_price_range) * average : 0 ) * ponderator
			end			
		end
		sub_total
	end
end
