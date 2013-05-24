class Tip < ActiveRecord::Base
	belongs_to :ceremony_type
	
	validates :ceremony_type_id, :presence => true
end
