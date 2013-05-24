class Bride < ActiveRecord::Base
  belongs_to :user_account
	belongs_to :address
	has_one :bride_image, :dependent => :destroy
	accepts_nested_attributes_for :address
  accepts_nested_attributes_for :bride_image, :reject_if => proc { |a| a[:bride].blank? }, :allow_destroy => true
  
  #validations
  validates :email, :email => true
  validates :rut, :rut => true, :allow_blank => true
  validates :phone, :phone_number => true, :allow_blank => true
  validates :name, :lastname_p, :email, :presence => true

	before_validation :correct_rut_format

	def check_data #DZF used to check if user_account has enough info
		if self.name.blank? or self.lastname_p.blank?
			return false
		else
			return true
		end
	end
	
	private
	# Correct format for Rut (a string without "." or "-")
	def correct_rut_format
	  self.rut.gsub!(/[-]|[.]/, "") unless self.rut.blank?
  end
end
