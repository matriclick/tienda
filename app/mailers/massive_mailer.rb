# encoding: UTF-8
class MassiveMailer < ActionMailer::Base
  default from: "mensajes@matriclick.com"
  
  def send_personalized_email(user_id, dresses_id)
  	@user = User.find user_id
		@dresses = dresses
  	mail to: "<#{@user.email}>", bcc: "matriclick_notice@matriclick.com", subject: "Hola! Te enviamos nuevos productos que sabemos te gustarán!"
  end
  
end