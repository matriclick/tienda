class Address < ActiveRecord::Base
  has_one :invitee
	belongs_to :region
	belongs_to :commune
	has_one :groom
	has_one :bride
	has_one :supplier_account
	#GeoCoder: http://railscasts.com/episodes/273-geocoder
	geocoded_by :get_address_string
  after_validation :geocode
  	
	accepts_nested_attributes_for :bride, :groom, :supplier_account
		
	def get_address
		string_address = self.street.to_s+' '+self.number.to_s+(self.commune.blank? ? '': ', '+self.commune.name.to_s )
		return string_address
	end
	  
	def get_address_string
		self.street.to_s+' '+self.number.to_s+(self.commune.blank? ? '': ', '+self.commune.name.to_s )+', Chile'
	end
	
end

