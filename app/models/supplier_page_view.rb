class SupplierPageView < ActiveRecord::Base
	belongs_to :supplier_account
	belongs_to :view_count_type
end
