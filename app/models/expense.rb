class Expense < ActiveRecord::Base
	belongs_to :user_account
	belongs_to :supplier_account
	belongs_to :product
	belongs_to :service
	belongs_to :industry_category
	has_many :payers, :dependent => :destroy


	# FGM: Alert!!! Form validations on expenses.js
	validate :industry_category_id_is_better_than_industry_category_name
	validate :supplier_account_id_is_better_than_supplier_account_fantasy_name
	validates :price, :quantity, :payed_percentage, :presence => true
	
	accepts_nested_attributes_for :payers
	
	def self.by_user_account(user_account)
		where(:user_account_id => user_account)
	end
	
	# FGM: Return a hash with key = industry_category_id, value = Array(Expenses of that industry_category)
	def self.grouped_by_industry_category_hash
		hash = {}
		industry_category_ids = group(:industry_category_id).collect {|x| x.industry_category_id}
		industry_category_ids.each do |id|
			# FGM: For those 'custom' expenses (not belonging to any category)
			if id.blank?
				industry_category_names = where(:industry_category_id => id).group(:industry_category_name).collect { |x| x.industry_category_name }
				industry_category_names.each { |name| hash.merge!( {name => where(:industry_category_name => name)} ) }
			else
				hash.merge!({id => self.where(:industry_category_id => id).all })
			end
		end
		hash
	end
	
	def industry_category_id_is_better_than_industry_category_name
		self.industry_category_name = nil if industry_category_id.present?
		
		if industry_category_id.blank?
			errors.add(:industry_category, "can't be blank") if industry_category_name.blank?
		end
	end
	
	def supplier_account_id_is_better_than_supplier_account_fantasy_name
		self.supplier_account_fantasy_name = nil if supplier_account_id.present?
	end
	
	def total_price
		price * quantity
	end
	
	def remaining_price
		total_price * (1 - payed_percentage_decimal)
	end
	
	def payed_price
		total_price * payed_percentage_decimal
	end
	
	def payed_percentage_decimal
		self.payed_percentage * 0.01
	end
end
