class IndustryCategorySeguridadPeru < ActiveRecord::Migration
  def up
    peru = Country.find_by_url_path('peru')
    servicios = IndustryCategoryType.find_by_name('Servicios')
    if !peru.blank? and !servicios.blank?
      seguridad = IndustryCategory.create(:name => 'seguridad', :industry_category_type_id => servicios.id, :budget_priority => 9, :position => 50, :hidden => false)
      seguridad.countries << peru
    end
  end

  def down
    peru = Country.find_by_url_path('peru')
    seguridad = IndustryCategory.find_by_name('seguridad')
    if !peru.blank? and !seguridad.blank?
      seguridad.countries.delete(peru)
      seguridad.destroy
    end
  end
end
