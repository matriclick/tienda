class SubCategoriesForCentrosDeEventos < ActiveRecord::Migration
  def up
    ic_centro = IndustryCategory.find_by_name('Centro de eventos')
    if !ic_centro.nil?      
      default_sub = (SubIndustryCategory.find_by_name(ic_centro.name) || SubIndustryCategory.create(:industry_category_id => ic_centro.id, :name => ic_centro.name, :description => (ic_centro.name + '.'), :position => 1))
      sub2 = (SubIndustryCategory.find_by_name('Complementos') || SubIndustryCategory.create(:industry_category_id => ic_centro.id, :name => 'Complementos', :description => 'Servicios complementarios como primeros auxilios.', :position => 2))
      
      supplier_accounts = SupplierAccount.all
      supplier_accounts.each do |supplier_account|
        if supplier_account.industry_categories.include?(ic_centro)
          supplier_account.sub_industry_categories << default_sub
        end
      end
    end
  end

  def down
  end
end
