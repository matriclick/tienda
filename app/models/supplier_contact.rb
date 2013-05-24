class SupplierContact < ActiveRecord::Base
	belongs_to :supplier_account
	belongs_to :contact_type
	
	before_validation :correct_phone_number_format
	
	validates :name, :phone_number, :presence => true
	validates :email, :presence => true, :email => true
	validates :phone_number, :phone_number => true
	
	private
	def correct_phone_number_format
	  self.phone_number = self.phone_number.gsub(/[^\d^+]/, "") unless self.phone_number.blank?
  end
end
