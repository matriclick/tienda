class NoMoreBooking < ActiveRecord::Base
	belongs_to :no_more_bookable, :polymorphic => true
	
	after_create :send_mail
	
	def send_mail
		#SupplierMailer.service_has_no_more_bookings_email(self).deliver
	end
end