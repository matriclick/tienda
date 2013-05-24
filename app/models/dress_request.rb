class DressRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :dress
  
  scope :from_type, 
	  lambda { |type| { :joins => {:dress => :dress_types}, :conditions => [ "dress_types.id = ?", type.id ] } }
	
end
