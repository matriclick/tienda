class ProductType < ActiveRecord::Base
	has_many :products
	belongs_to :industry_category
	
	def self.of_supplier(supplier)
		self.belongs_to_industry_categories?(supplier.supplier_account.industry_categories)
	end
	
	def self.belongs_to_industry_categories?(industry_categories)
		where(:industry_category_id => industry_categories)
	end
end
