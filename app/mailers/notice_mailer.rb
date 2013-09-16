# coding: utf-8
class NoticeMailer < ActionMailer::Base
	default from: "mensajes@tramanta.com"
  
	#CONTACT
  def refund_request_email(refund_request)
    @refund_request = refund_request
  	mail to: "equipo-tramanta@matriclick.com", subject: "Devolución en Tramanta.com"
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

	#WEDDING PLANNER
  def wedding_planner_email(wedding_planner_quote, action)
  	@wedding_planner_quote = wedding_planner_quote
  	@action = action
  	mail to: "equipo-tramanta@matriclick.com", subject: action+" cotización Wedding Planner Tramanta.com"
  end
  
  #FEEDBACK
  def feedback_email(feedback)
  	@feedback = feedback
  	mail to: "equipo-tramanta@matriclick.com", subject: "Feedback en Tramanta.com"
  end
  
  #FEEDBACK
  def review_email(review)
  	@review = review
  	@supplier = review.reviewable
  	mail to: "equipo-tramanta@matriclick.com", subject: "Review en Tramanta.com"
  end
  
  #PRODUCT
  def product_email(product)
  	@product = product
  	mail to: "equipo-tramanta@matriclick.com", subject: "Alerta Precio producto en Tramanta.com"
  end

  #SERVICE
  def service_email(service)
  	@service = service
  	mail to: "equipo-tramanta@matriclick.com", subject: "Alerta Precio producto en Tramanta.com"
  end
  
  #REFERENCE
  def reference_request_email(reference_request)
  	@reference_request = reference_request
  	@supplier = reference_request.supplier_account.supplier
  	mail to: "equipo-tramanta@matriclick.com", subject: "Referencias en Tramanta.com"
  end

	# MATRICLICK POINTS
	def matriclick_points_email(user, expense)
		@user = user
		@expense = expense
		mail to: "equipo-tramanta@matriclick.com", subject: "Se registró un gasto para Puntos Tramanta"
	end
  
end
