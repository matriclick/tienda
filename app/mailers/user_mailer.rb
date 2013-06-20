# encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "mensajes@matriclick.com"
  
  def user_email(user, password) # when a UserAccount add a new user to his people
  	@user = user
		@password = password
  	mail to: "<#{@user.email}>", bcc: "contacto@tramanta.com", subject: "[Matriclick.com] Se ha creado un nuevo usuario"
  end
  
  # LO QUIERO MAMÁ
	def send_i_want_it(mail_inline)
	  @sender_name = mail_inline.sender_name
	  @sender_last_name = mail_inline.sender_last_name
	  @recipient_email = mail_inline.recipient_email
	  @message = mail_inline.message
    @dress_url = mail_inline.dress_url
    @dress_image_url = mail_inline.dress_image_url

		mail to: "#{@recipient_email}", bcc: "contacto@tramanta.com", from: "#{@sender_name} #{@sender_last_name} <no-reply@matriclick.cl>", reply_to: "contacto@tramanta.com", subject: "¡#{@sender_name} #{@sender_last_name} quiere que le regales esto!"
	end

	#DRESS REQUEST
	def dress_request_to_seller_email(dress, user, dress_url)
		@dress = dress
		@user = user
		@dress_url = dress_url
		if @dress.supplier_account.supplier_account_type.name == 'Vestidos de Novia Usados'
      email = @dress.seller_email
      @name = @dress.seller_name
    else
      contact = @dress.supplier_account.supplier_contacts.first
      email = contact.email
      @name = contact.name
    end
    
		mail to: "#{email}", bcc: %w{contacto@tramanta.com}, subject: "[Matriclick.com] Cotización de Vestido "+@dress.dress_type.name
	end
	
	def dress_request_to_buyer_email(dress, user, dress_url)
		@dress = dress
		@user = user
		@dress_url = dress_url
		if @dress.supplier_account.supplier_account_type.name == 'Vestidos de Novia Usados'
      @email = @dress.seller_email
      @name = @dress.seller_name
      @phone_number = @dress.seller_phone_number
    else
      contact = @dress.supplier_account.supplier_contacts.first
      @email = contact.email
      @name = contact.name
      @phone_number = contact.phone_number
    end
    
		mail to: "#{@user.email}", bcc: %w{contacto@tramanta.com}, subject: "[Matriclick.com] Cotización de Vestido "+@dress.dress_type.name
	end

	# SUELTA LA ROCA
	def rock_email(rock, to_sender = false)
		@rock = rock
		@country_url_path = 'chile'
		if to_sender
			mail to: @rock.sender_email, subject: "[Matriclick.com] Has enviado esta postal a #{@rock.recipient_name} (#{@rock.recipient_email})"
		else
			mail to: "#{@rock.recipient_name} <#{@rock.recipient_email}>", from: "#{@rock.sender_name} <no-reply@matriclick.cl>", reply_to: "#{@rock.sender_email}", subject: "[Matriclick.com] Una postal de #{@rock.sender_name}"
		end		
	end

  # BOOKINGS
  def booking_confirmation_email(booking)
  	@booking = booking
  	@country_url_path = @booking.supplier_account.country.url_path
  	@bookable = @booking.bookable
  	@supplier_account = @booking.supplier_account
  	mail to: "<#{@booking.user_account.users.first.email}>", bcc: "matriclick_notice@matriclick.com ", subject: "[Matriclick.com] Tu reserva por '#{@bookable.name}' ha sido confirmada"
  end
  
  def booking_deletion_email(booking)
  	@booking = booking
  	@bookable = @booking.bookable
  	@supplier_account = @booking.supplier_account
  	mail to: "<#{@booking.user_account.users.first.email}>", bcc: "matriclick_notice@matriclick.com ", subject: "[Matriclick.com] Tu reserva por '#{@bookable.name}' ha sido cancelada"
  end
  
	def booking_resources_full_email(booking)
		@booking = booking
		@bookable = @booking.bookable
		@supplier_account = @booking.supplier_account
		mail to: "<#{@booking.user_account.users.first.email}>", bcc: "matriclick_notice@matriclick.com ", subject: "[Matriclick.com] Tu reserva por '#{@bookable.name}' no podrá ser confirmada"
	end

	# BEGIN AMK 2012-11-29
	# booking_is_expired_email NO EXISTE COMO ACCION en "app/mailers/user_mailer.rb". Solo existe el template "app/views/user_mailer/booking_is_expired_email.html.erb".
	# Por otro lado, en "app/mailers/user_mailer.rb" existe la accion booking_expired_email(booking), pero no existe el template "app/views/user_mailer/booking_expired_email.html.erb"
	# Voy a comentar estos llamados para evitar problemas ya que no se usan
	#
  # def booking_expired_email(booking)
	#   @booking = booking
	#	  @bookable = @booking.bookable
	#	  @supplier_account = @booking.supplier_account
	#	  mail to: "<#{@booking.user_account.users.first.email}>", bcc: "matriclick_notice@matriclick.com ", subject: "[Matriclick.com] Tu reserva por '#{@bookable.name}' ha expirado"
	# end
	# END AMK 2012-11-29
    
  #CONVERSATIONS
  # a supplier respond to a message
  def supplier_respond_message_email(message, user) #Cant get the user_email from message
  	@message = message
  	@user = user
    @country_url_path = @message.conversation.supplier_account.country.url_path
  	@conversation = @message.conversation
  	@supplier_account = @conversation.supplier_account
  	mail to: "<#{@user.email}>", bcc: "contacto@tramanta.com ", subject: "[Matriclick.com] El proveedor #{@supplier_account.fantasy_name} ha respondido a tu mensaje"
  end
  
	# REMINDERS
  def reminder_email(activity_reminder)
   	@activity_reminder = activity_reminder
   	@country_url_path = @activity_reminder.activity.user_account.country.url_path
 		mail to: "<#{@activity_reminder.mail}>", bcc: "contacto@tramanta.com ", subject: "[Matriclick.com] Recordatorio de Actividad en Checklist."
  end

end
