class OpportunityImage < ActiveRecord::Base
  belongs_to :opportunity
  
  has_attached_file :opportunity_image, :styles => {
		:thumb => "100x100>",
		:smaller => "120x90>",
		:regular => "400x500>"
	}, :whiny => false
  
  validates_attachment_size :opportunity_image, :less_than => 7.megabytes
  
end
