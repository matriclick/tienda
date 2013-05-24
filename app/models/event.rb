class Event < ActiveRecord::Base
  belongs_to :service
	belongs_to :user_account
	belongs_to :user
	belongs_to :supplier_account
	has_one :attachednote, :as => :attachable
	accepts_nested_attributes_for :attachednote, :allow_destroy => true
	
	default_scope where(:soft_deleted => false)

  # Validations
  validates :title, :date, :service_id, :presence => true
  validates :email, :email => true # email standard format DZF
  
  # after_create :send_warning_email_if_too_many_bookings, :send_warning_email_if_expired_or_confirmed
  # after_update :send_warning_email_if_too_many_bookings, :send_warning_email_if_expired_or_confirmed
	# FGM: DIsabled mailing
  # after_create :send_mail_user_make_booking
  # before_destroy :send_mail_user_delete_booking
  # after_update :send_mail_to_user
  
  def send_mail_user_make_booking #DZF this always send a mail to supplier
  	SupplierMailer.user_make_booking_email(self).deliver unless self.user_account.blank?
  end
  
  def send_mail_user_delete_booking #DZF send mail to supplier when a user delete one of his booking
  	SupplierMailer.user_delete_a_booking_email(self).deliver
  end
  
  def send_mail_to_user
  	if self.booking_confirmed
  		UserMailer.booking_is_confirmed_email(self).deliver unless self.user.blank? #DZF when a booking is confirmed
  		NoticeMailer.event_email_expired_or_confirmed(self).deliver
  		#user cant booking logic
  		check_possible_confirmed_bookings(self) #DZF check another bookings that could not be confirmed
  	elsif self.unconfirmed
  		UserMailer.booking_is_unconfirmed_email(self).deliver unless self.user.blank? #DZF when a booking is unconfirmed
  	elsif self.soft_deleted
  		SupplierMailer.user_delete_a_booking_email(self).deliver
  	end
  	# BEGIN AMK 2012-11-29
  	# booking_is_expired_email NO EXISTE COMO ACCION en "app/mailers/user_mailer.rb". Solo existe el template "app/views/user_mailer/booking_is_expired_email.html.erb".
  	# Por otro lado, en "app/mailers/user_mailer.rb" existe la accion booking_expired_email(booking), pero no existe el template "app/views/user_mailer/booking_expired_email.html.erb"
 		# Voy a comentar estos llamados para evitar problemas ya que no se usan
 		#
 		# UserMailer.booking_is_expired_email(self).deliver if self.expired #DZF when a booking is set to expired
 		# END AMK 2012-11-29
  	
 		NoticeMailer.event_email_expired_or_confirmed(self)
  end
  
  def check_possible_confirmed_bookings(event)
		if Event.where(:service_id => event.service_id, :date => event.date, :booking_confirmed => true).count >= event.service.max_confirmed_bookings
			Event.where(:service_id => event.service_id, :date => event.date, :booking_confirmed => false).each do |e|
				UserMailer.booking_can_not_be_confirmed_email(e).deliver
			end
		end
  end

  def send_warning_email_if_expired_or_confirmed
  	if self.expired || self.booking_confirmed
  		NoticeMailer.event_email_expired_or_confirmed(self).deliver
  	end
  end
  
  def send_warning_email_if_too_many_bookings
  	NoticeMailer.event_email(events_by_user_account_date_and_industry_category).deliver if check_events_from_this_user_today #10
  end

	def self.by_date(date)
		where :date => date
	end
	
	def self.confirmed
		where :booking_confirmed => true
	end
  
	def self.read
		where :read => true
	end
	
	def self.supplier_unread
		where :supplier_read => false, :related_confirm => false
	end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
  
  def self.by_places(ids)
    find(:all, :joins => :service, :conditions => ["places.id in (?)", ids] )
  end
  
	def self.bookings_by_user_account(user_account, confirmed = false)
		where :user_account_id => user_account.id, :booking_confirmed => confirmed
	end
  
  def self.by_service_without_personal(service_id)
  	where(:service_id => service_id)
  end
  
  def check_events_from_this_user_today
  	if events_by_user_account_date_and_industry_category.count > 10
  		return true
		else
			return false
  	end
  end
  
  def events_by_user_account_date_and_industry_category
  	Event.joins(:service => :industry_category).where('industry_categories.id' => self.service.industry_category_id, :user_account_id => self.user_account_id, :date=> self.date)
  end

	def is_confirmable?
		service.events.by_date(self.date).confirmed.count < service.max_confirmed_bookings
	end

	def can_not_be_confirmed? #DZF this isn't controlling the :expire field
		return true if self.booking_confirmed != true and self.expired != true and self.service.max_confirmed_bookings <= Event.where(:booking_confirmed => true, :service_id => self.service_id, :date => self.date).count
	end
	
	def get_booking_class
		return 'is_expired' if self.expired
		return 'can_not_be_confirmed' if self.can_not_be_confirmed?
		return 'related_confirm' if self.related_confirm
		return 'is_confirmed' if self.booking_confirmed
		return 'is_unconfirmed' if self.unconfirmed and !self.booking_confirmed
	end
	
	def self.user_unread_count
		where(:user_read => false).count
	end
	
	def self.supplier_unread_count
		where(:supplier_read => false, :related_confirm => false).count
	end
	
 	def self.include_deleted_in(user_account_id) #DZF this override the event's default_scope, use carefully
		self.with_exclusive_scope{ Event.find(:all, :conditions => {:soft_deleted =>true, :user_read => false, :user_account_id => user_account_id}) }
	end
	
	def self.get_soft_deleted_by_id(event_id)
		self.with_exclusive_scope{ Event.find(:all, :conditions => {:id => event_id})}
	end
end
