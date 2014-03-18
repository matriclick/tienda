class SiteConfigurationHomeCategory < ActiveRecord::Base
  belongs_to :site_configuration
  belongs_to :home_category
end
