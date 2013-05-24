class IndustryCategoriesCountriesRelation < ActiveRecord::Migration
  def change
    chile = Country.find_by_url_path('chile')
    peru = Country.find_by_url_path('peru')
    industry_categories = IndustryCategory.unscoped # ".all" Method is overwritten in the model
    sub_industry_categories = SubIndustryCategory.all
    
    if !chile.blank? and !peru.blank?
      industry_categories.each do |industry_category|
        industry_category.countries << chile
        if %w[coros fotografia_y_video peinado_y_maquillaje banqueteras partes_y_detalles].include? industry_category.name
          industry_category.countries << peru
        end
      end
      sub_industry_categories.each do |sub_industry_category|
        sub_industry_category.countries << chile
      end
    end
  end
  
end
