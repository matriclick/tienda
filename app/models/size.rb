class Size < ActiveRecord::Base
	has_many :dress_stock_sizes, :dependent => :destroy
	has_many :dresses, :through => :dress_stock_sizes
	has_and_belongs_to_many :dress_types
  
	
end
