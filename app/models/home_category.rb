class HomeCategory < ActiveRecord::Base
  has_and_belongs_to_many :dress_types
  has_many :site_configuration_home_categories, :dependent => :destroy
  has_many :site_configurations, :through => :site_configuration_home_categories

	validates :title, :category_keyword_for_url, :see_more_text, :presence => true	
    
  def dresses
    dresses_array = Array.new
    self.dress_types.each do |dt|
      dresses_array.concat dt.dresses.available_to_purchase.order 'created_at DESC'
    end
    return dresses_array.sort { |x,y| y.created_at <=> x.created_at }
  end
end
