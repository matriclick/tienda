class DeleteSubIndustryTransInvit < ActiveRecord::Migration
  def up
    if !SubIndustryCategory.find_by_name("Transporte para Invitados").nil?
      SubIndustryCategory.find_by_name("Transporte para Invitados").destroy
    end
    if SubIndustryCategory.find_by_name("Transporte para Invitados (conductores)").nil? and !IndustryCategory.find_by_name("Transporte").nil?
      SubIndustryCategory.create(:name => 'Transporte para Invitados (conductores)', :position => 1, :industry_category_id => IndustryCategory.find_by_name("Transporte").id, :description => "Transporte para Invitados como liebres, conductores, etc.")
    end
  end

  def down
  end
end
