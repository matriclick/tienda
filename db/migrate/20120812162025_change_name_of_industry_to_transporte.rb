class ChangeNameOfIndustryToTransporte < ActiveRecord::Migration
  def up
    ic =  IndustryCategory.find_by_name("Transporte novios");
    if !ic.nil?
		ic.update_attribute :name, 'Transporte'
	end
  end

  def down
    ic =  IndustryCategory.find_by_name("Transporte");
    if !ic.nil?
		ic.update_attribute :name, 'Transporte novios'
	end
  end
end
