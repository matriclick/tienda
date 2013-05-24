class BudgetInviteeCount < ActiveRecord::Base
	belongs_to :user_account
	belongs_to :budget_invitation_type
	
	def self.party
		joins(:budget_invitation_type).where('budget_invitation_types.name like "%fiesta%"')
	end
	
	def self.dinner
		joins(:budget_invitation_type).where('budget_invitation_types.name like "%comida%"')
	end
	
	def kind_of_invitation
		budget_invitation_type.name[budget_invitation_type.name.index("la ")..budget_invitation_type.name.length-1]
	end
	
	def total_count
		groom + bride + g_parents + b_parents
	end
end