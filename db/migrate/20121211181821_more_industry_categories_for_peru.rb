# encoding: UTF-8
class MoreIndustryCategoriesForPeru < ActiveRecord::Migration
  def up
    peru = Country.find_by_url_path('peru')
    industry_categories = IndustryCategory.where(:name => ['carpas_y_baños', 'cotillon', 'dj_y_musica'])
    
    if !peru.blank?
      industry_categories.each do |industry_category|
        industry_category.countries << peru
      end
    end

  end

  def down
    peru = Country.find_by_url_path('peru')
    industry_categories = IndustryCategory.where(:name => ['carpas_y_baños', 'cotillon', 'dj_y_musica'])
    
    if !peru.blank?
      industry_categories.each do |industry_category|
        industry_category.countries.delete(peru)
      end
    end
    
  end
end
