class ServiceBudget < ActiveRecord::Base
	belongs_to :user_account
	belongs_to :service
	belongs_to :budget_type
	
	def self.type(name)
		joins(:budget_type).where("budget_types.name = ?", name)
	end

	def self.by_service_ids(ids)
		where(:service_id => ids)
	end
end
