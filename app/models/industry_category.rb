class IndustryCategory < ActiveRecord::Base
  belongs_to :industry_category_type
  has_many :albums
	has_many :product_types
	has_many :products
	has_many :services
	has_many :posts
	has_many :sub_industry_categories
  has_many :leads
  has_and_belongs_to_many :supplier_accounts
	has_and_belongs_to_many :countries
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
	# Validations
	
	def has_discount
	  self.supplier_accounts.each do |sa|
	    if sa.has_discount
	      return true
      end
    end
    return false    	  
  end
  
  def has_discount_for_country(country)
	  self.supplier_accounts.where(:country_id => country.id).each do |sa|
	    if sa.has_discount
	      return true
      end
    end
    return false    	  
  end
  
  def self.by_products(ids)
    joins(:products).where("products.id in (?)",ids).group(:industry_category_id)
  end
  
  def self.by_services(ids)
    joins(:services).where("services.id in (?)",ids).group(:industry_category_id)
  end

	def products_and_services_count
		products.approved.count + services.approved.count
	end
	
	def self.all 
	  self.where('industry_category_type_id <> ?', IndustryCategoryType.find_by_name('Especiales').id)
  end
  
  def get_suppliers_accounts
      @sat = SupplierAccountType.find_by_name('Regular')
      self.supplier_accounts.where(:supplier_account_type_id => @sat.id).approved.sort_by {|sa| -sa.supplier_page_views.where('updated_at > ?', (Time.now - 7.day)).size }
  end
  
  def get_suppliers_accounts_for_country(country)
      @sat = SupplierAccountType.find_by_name('Regular')
      self.supplier_accounts.where(:country_id => country.id, :supplier_account_type_id => @sat.id).approved.sort_by {|sa| -sa.supplier_page_views.where('updated_at > ?', (Time.now - 7.day)).size }
  end
  
  def get_name
    return I18n.t("models.industry_category.#{self.name}")
  end
  
end
