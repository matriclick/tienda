class ProductBudget < ActiveRecord::Base
	belongs_to :user_account
	belongs_to :product
	belongs_to :budget_type
	
	def self.type(name)
		joins(:budget_type).where("budget_types.name = ?", name)
	end
	
	def self.included
		where(:included => true)
	end

	def self.by_product_ids(ids)
		where(:product_id => ids)
	end
end
