class IndustryCategoryType < ActiveRecord::Base
  has_many :industry_categories

  def industry_categories_by_supplier_account(supplier_account)
  	industry_categories.find(:all, :joins => :supplier_accounts, :conditions => ["supplier_accounts.id = ?", supplier_account.id])
  end
end
