class DeliveryInfo < ActiveRecord::Base
  has_many :purchases
  belongs_to :user
  belongs_to :commune
	accepts_nested_attributes_for :purchases
	#GeoCoder: http://railscasts.com/episodes/273-geocoder
	geocoded_by :get_address_string
  after_validation :geocode
  
	validates  :name, :rut, :contact_phone, :street, :number, :commune_id, :presence => true
	
	def get_address_string
	  if !self.commune.nil?
	    return self.street.to_s+' '+self.number.to_s+' '+self.apartment.to_s+' '+self.commune.name.to_s+', Chile'
    else
      return self.street.to_s+' '+self.number.to_s+' '+self.apartment.to_s+', Chile'
	  end
  end
  
end
