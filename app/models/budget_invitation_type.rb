class BudgetInvitationType < ActiveRecord::Base
	has_many :budget_invitee_counts
	has_many :budgets
	
	def self.party_and_dinner
		where('name not like "%total%"')
	end
end
