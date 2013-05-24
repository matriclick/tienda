class BookingsController < ApplicationController
	before_filter :load_user_account
	before_filter :authenticate_user!
	before_filter :authenticate_guest, :only => [:booking_list]

	# USER Actions
  def booking_list
  	@bookings = current_user.user_account.bookings.by_status(:except => [:destroyed, :deleted_by_user])
  end
    
  def update_booking
		@booking = Booking.find params[:id]

		# FGM: Update read status or deletion status
		unless params[:read].present?
			params[:booking].present? ? @booking.update_attributes(params[:booking]) : @booking.update_attribute(:status, Booking::STATUS[:destroyed])
			@booking.read_status :only_user => true
		else
			@booking.read_status :user => true
		end

		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
  end

	# SUPPLIER Actions
	
end
