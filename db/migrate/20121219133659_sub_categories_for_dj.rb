# encoding: UTF-8
class SubCategoriesForDj < ActiveRecord::Migration
  def up
    ic_dj = IndustryCategory.find_by_name('dj_y_musica')
    if !ic_dj.nil?      
      sub1 = (SubIndustryCategory.find_by_name('dj_productora') || SubIndustryCategory.create(:industry_category_id => ic_dj.id, :name => 'dj_productora', :description => 'DJ - Productoras.', :position => 1))
      sub2 = (SubIndustryCategory.find_by_name('dj_independiente') || SubIndustryCategory.create(:industry_category_id => ic_dj.id, :name => 'dj_independiente', :description => 'DJ - Independientes.', :position => 2))
      
      supplier_accounts = SupplierAccount.approved
      supplier_accounts.each do |supplier_account|
        if supplier_account.industry_categories.include?(ic_dj)
          case supplier_account.public_url
            when 'jotamatrimonios', 'jfkproducciones', 'hurtadoyasociados', 'laboogie', 'rollaway', 'eventplanning', 'vjmundy', 'calumontt', 'ricardolecaros', 'djsap', 'fgaudio'
              supplier_account.sub_industry_categories << sub1
            else
              supplier_account.sub_industry_categories << sub2
          end
        end
      end
    end
  end

  def down
  end

end


