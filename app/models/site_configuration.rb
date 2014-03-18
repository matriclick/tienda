class SiteConfiguration < ActiveRecord::Base
  belongs_to :contest
  has_many :site_configuration_home_categories, :dependent => :destroy
  has_many :home_categories, :through => :site_configuration_home_categories
  
  accepts_nested_attributes_for :site_configuration_home_categories, :allow_destroy => true
end
