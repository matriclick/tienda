class CreateIndustryCategoryViajes < ActiveRecord::Migration
  def up
    ict = IndustryCategoryType.find_by_name("Especiales")
    chile = Country.find_by_name('Chile')
    
    aux = IndustryCategory.find_by_name("viajes") || IndustryCategory.create(:name => 'viajes', :industry_category_type_id => ict.id, 
    :budget_priority => 100, :position => 999, :hidden => true, :item_seller => false)
    
    aux.countries << chile
  end

  def down
  end
end
