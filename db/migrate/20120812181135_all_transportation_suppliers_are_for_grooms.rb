class AllTransportationSuppliersAreForGrooms < ActiveRecord::Migration
  def up
    
    if !IndustryCategory.find_by_name("Transporte").nil?
		if SubIndustryCategory.find_by_name("Transporte para Invitados").nil?
		  SubIndustryCategory.create(:name => 'Transporte para Invitados', :position => 1, :industry_category_id => IndustryCategory.find_by_name("Transporte").id, :description => "Transporte para Invitados como liebres, conductores, etc.")
		end
		if SubIndustryCategory.find_by_name("Transporte para Novios").nil?
		  SubIndustryCategory.create(:name => 'Transporte para Novios', :position => 2, :industry_category_id => IndustryCategory.find_by_name("Transporte").id, :description => "Transporte para Novios como autos lujosos.")
		end
	end
    
    
    ic = IndustryCategory.find_by_name("Transporte")
    sic = SubIndustryCategory.find_by_name("Transporte para Novios")
	if !ic.nil? and !sic.nil?
		sas = ic.supplier_accounts
		sas.each do |sa|
			sa.sub_industry_categories << sic
			sa.save
		end
    end
  end

  def down
  end
end
