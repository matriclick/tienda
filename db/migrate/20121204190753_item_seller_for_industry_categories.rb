class ItemSellerForIndustryCategories < ActiveRecord::Migration
  def change
    add_column :industry_categories, :item_seller, :boolean, :default => false

    vestidos_de_fiesta = IndustryCategory.find_by_name('vestidos_de_fiesta')
    vestidos_de_fiesta.update_attributes(:item_seller => true) if !!vestidos_de_fiesta
    
    vestidos_y_calzado_novia = IndustryCategory.find_by_name('vestidos_y_calzado_novia')
    vestidos_y_calzado_novia.update_attributes(:item_seller => true) if !!vestidos_y_calzado_novia
    
    ajuar = IndustryCategory.find_by_name('ajuar')
    ajuar.update_attributes(:item_seller => true) if !!ajuar
  end
end
