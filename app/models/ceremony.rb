class Ceremony < ActiveRecord::Base
	belongs_to :ceremony_type
	has_many :ceremony_images, :dependent => :destroy
	belongs_to :address
	has_many :ceremony_days
	
	validates :ceremony_type_id, :presence => true
	accepts_nested_attributes_for :ceremony_images, :reject_if => proc { |a| a[:image].blank? }, :allow_destroy => true
	accepts_nested_attributes_for :address
	accepts_nested_attributes_for :ceremony_days
	
	def get_ceremony_leader
		ceremony_type_name = self.ceremony_type.name.gsub(/\s/,"_").gsub(/[\u0080-\u00ff]/,"")
		
		case ceremony_type_name
			when 'Civil'
				return 'civil_official'
			when 'Catlica'
				return 'parson'
			when 'Juda'
				return 'rabbi'
			when 'Evanglica'
				return 'pastor'
			else
				return 'name'
		end
		
	end
end
