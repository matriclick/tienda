class DressType < ActiveRecord::Base
  has_and_belongs_to_many :dresses
  has_and_belongs_to_many :sizes
  has_and_belongs_to_many :home_categories
  
  def self.get_options(supplier_account)
    return DressType.order 'name'
  end
  
  def get_human_name
	  return self.name.gsub('-', ' ').capitalize
  end
  
end
