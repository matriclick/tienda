# coding: utf-8
class NoticeMailer < ActionMailer::Base
	default from: "mensajes@tramanta.com"
  
	#CONTACT
  def refund_request_email(refund_request)
    @refund_request = refund_request
  	mail to: @refund_request.user.email, bcc: "equipo-tramanta@matriclick.com", subject: "Devolución en Tramanta.com"
  end
	
	#CONTACT
  def contact_email(contact)
  	@contact = contact
  	mail to: "equipo-tramanta@matriclick.com", subject: "Contacto en Tramanta.com"
  end

	#PURCHASE
  def purchase_email(purchase)
  	@purchase = purchase
  	@purchasable = purchase.purchasable
  	mail to: @purchase.user.email, bcc: "equipo-tramanta@matriclick.com", subject: "Compra en Tramanta.com"
  end
  
  def dress_stock_change_notification_email(dress_stock_change_notification)
    @dscn = dress_stock_change_notification
    mail to: @dscn.email, bcc: "equipo-tramanta@matriclick.com", subject: "¡El producto que buscabas está disponible!"
  end

end
