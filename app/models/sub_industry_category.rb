class SubIndustryCategory < ActiveRecord::Base
    belongs_to :industry_category
    has_and_belongs_to_many :supplier_accounts
    has_and_belongs_to_many :countries
  	
    def get_suppliers_accounts
        @sat = SupplierAccountType.find_by_name('Regular')
        self.supplier_accounts.where(:supplier_account_type_id => @sat.id).approved.sort_by {|sa| -sa.supplier_page_views.where('updated_at > ?', (Time.now - 7.day)).size }
    end
    
    def get_suppliers_accounts_for_country(country)
        @sat = SupplierAccountType.find_by_name('Regular')
        self.supplier_accounts.where(:country_id => country.id, :supplier_account_type_id => @sat.id).approved.sort_by {|sa| -sa.supplier_page_views.where('updated_at > ?', (Time.now - 7.day)).size }
    end

    def get_name
      return I18n.t("models.sub_industry_category.#{self.name}")
    end
    
end
