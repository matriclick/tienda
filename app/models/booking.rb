class Booking < ActiveRecord::Base
	after_save :destroy_related_bookings_on_date, :block_date_if_resources_occupied, :send_notification_emails, :unless => proc { |a| a.status == STATUS[:custom] }

	has_one :attachednote, :as => :attachable, :dependent => :destroy #Documento adjunto que se puede enviar
	belongs_to :user_account #Novio que reserva
	belongs_to :supplier_account #Proveedor
	belongs_to :bookable, :polymorphic => true #Plymorphic: puede ser un producto o servicio

	validates :date, :presence => true
	
	accepts_nested_attributes_for :attachednote, :reject_if => lambda {|a| a[:message].blank?}
	
	# FGM: Do not modify these constants!
	STATUS = {
		:pending => "Booking has been created and is waiting for supplier confirmation",
		:confirmed => "Booking has been confirmed by supplier",
		:related_confirmed => "Another booking related to the same user and bookable has been confirmed. This one has to be deleted",
		:deleted_by_supplier => "Supplier deleted it. A reason must be specified",
		:deleted_by_user => "It was confirmed and the user deleted it. A reason must be specified",
		:expired => "Booking date has passed",
		:destroyed => "User/Supplier confirmed its deletion.",
		:custom => "Supplier created it manually to represent a 'external' booking."
	}
	READ_STATUS = {
		:unread => "Nobody has read this booking",
		:read_by_supplier => "Read by supplier",
		:read_by_user => "Read by user",
		:read_by_supplier_and_user => "Read by supplier and user"
	}
	
	def self.by_status(options = {:status => :pending}) 
		if options[:except].present?
			# FGM: Break down options for exception of statuses 
			options[:except].is_a?(Array) ? except_statuses = options[:except].map {|s| STATUS[s]} : except_statuses = STATUS[options[:except]]
			where("status not in (?)", except_statuses)
		else
			options[:status].is_a?(Array) ? selected_statuses = options[:status].map {|s| STATUS[s]} : selected_statuses = STATUS[options[:status]]
			where(:status => selected_statuses)
		end
	end
	
	def self.by_read_status(options = {:status => :unread}) 
		if options[:except].present?
			# FGM: Break down options for exception of statuses 
			options[:except].is_a?(Array) ? except_statuses = options[:except].map {|s| READ_STATUS[s]} : except_statuses = READ_STATUS[options[:except]]
			where("bookings.read not in (?)", except_statuses)
		else
			options[:status].is_a?(Array) ? selected_statuses = options[:status].map {|s| READ_STATUS[s]} : selected_statuses = READ_STATUS[options[:status]]
			where(:read => selected_statuses)
		end
	end
	
	def is_confirmable?
		self.status == STATUS[:pending] &&
		self.supplier_account.booking_resources - 
		self.supplier_account.bookings.where(:date => self.date).by_status(status: :confirmed).map{|b| b.bookable.booking_resources_consumed}.sum >=
		self.bookable.booking_resources_consumed
	end
	
	def send_notification_emails
		case self.status
		when STATUS[:pending]
			logger.info  "---------> SEND CREATION EMAIL: #{self.inspect}"
			SupplierMailer.new_booking_email(self).deliver
		when STATUS[:confirmed]
			logger.info  "---------> SEND CONFIRMATION EMAIL: #{self.inspect}"
			UserMailer.booking_confirmation_email(self).deliver
		when STATUS[:deleted_by_supplier]
			logger.info  "---------> SEND DELETED BY SUPPLIER EMAIL: #{self.inspect}" 
			UserMailer.booking_deletion_email(self).deliver
		when STATUS[:deleted_by_user]
			logger.info  "---------> SEND DELETED BY USER EMAIL: #{self.inspect}"
			SupplierMailer.booking_deletion_email(self).deliver
		when STATUS[:expired]
			logger.info  "---------> SEND EXPIRED EMAIL: #{self.inspect}"
			# BEGIN AMK 2012-11-29
    	# booking_is_expired_email NO EXISTE COMO ACCION en "app/mailers/user_mailer.rb". Solo existe el template "app/views/user_mailer/booking_is_expired_email.html.erb".
    	# Por otro lado, en "app/mailers/user_mailer.rb" existe la accion booking_expired_email(booking), pero no existe el template "app/views/user_mailer/booking_expired_email.html.erb"
    	# Voy a comentar estos llamados para evitar problemas ya que no se usan
    	#
      # UserMailer.booking_expired_email(self).deliver
    	# END AMK 2012-11-29
		end
	end

	# Se encarga de manjear el bloqueo de las fechas
	def block_date_if_resources_occupied
		# FGM: Create NoMoreBooking for this "bookable" on corresponding date
		if self.supplier_account.should_create_no_more_booking? self.date
			n = NoMoreBooking.create!(:date => self.date, :no_more_bookable_id => self.bookable_id, :no_more_bookable_type => self.bookable_type) if NoMoreBooking.where(:date => self.date, :no_more_bookable_id => self.bookable_id, :no_more_bookable_type => self.bookable_type).first.blank?
			# FGM: Notify other users on waiting list for same 'bookable' on corresponding date
			self.bookable.bookings.by_status(status: :pending).each { |b| UserMailer.booking_resources_full_email(b).deliver }
		else
		 	NoMoreBooking.where(:date => self.date, :no_more_bookable_id => self.bookable_id, :no_more_bookable_type => self.bookable_type).delete_all
		end
	end
	
	def destroy_related_bookings_on_date
		# FGM: Delete other bookings for the same service and user
		if self.status == STATUS[:confirmed]
			unless self.user_account_id.blank?
				related_bookings = Booking.where(:user_account_id => self.user_account_id, :bookable_type => self.bookable_type, :bookable_id => self.bookable_id).by_status(status: :pending).update_all(:status => STATUS[:related_confirmed], :read => READ_STATUS[:unread])
			end
		elsif self.status == STATUS[:deleted_by_user]
			unless self.user_account_id.blank?
				related_bookings = Booking.where(:user_account_id => self.user_account_id, :bookable_type => self.bookable_type, :bookable_id => self.bookable_id).by_status(status: :related_confirmed).update_all(:status => STATUS[:destroyed], :read => READ_STATUS[:read_by_user])
			end
		end
	end
	
	# FGM: Sets booking read status. E.g. Booking.first.read_status(:supplier => true)
	# FGM: Returns read status or checks if Booking is read by supplier or user (e.g. Booking.first.read_status(:by => :supplier))
	# Skips callbacks (to avoid sending emails)
	def read_status(*args)
		options = args.extract_options!

		read = self.read
		
		if options[:only_user].present?
			read = READ_STATUS[:read_by_user]
		elsif options[:only_supplier].present?
			read = READ_STATUS[:read_by_supplier]
		else
			if options[:user].present?
				self.read_status(by: :supplier) ? read = READ_STATUS[:read_by_supplier_and_user] : read = READ_STATUS[:read_by_user]
			elsif options[:supplier].present?
				self.read_status(by: :user) ? read = READ_STATUS[:read_by_supplier_and_user] : read = READ_STATUS[:read_by_supplier]
			elsif options[:user].present? && options[:supplier].present?
				read = READ_STATUS[:read_by_supplier_and_user]
			elsif options[:user] == false && options[:supplier] == false
				read = READ_STATUS[:unread]
			end
		end

		puts self.inspect
		# FGM: Skips callbacks
		self.read = read
		self.update_column(:read, read) and self.touch if self.changed?
		
		options[:by].present? ? self.read.include?(options[:by].to_s) : self.read
	end
end