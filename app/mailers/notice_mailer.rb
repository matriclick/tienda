# coding: utf-8
class NoticeMailer < ActionMailer::Base
	default from: "mensajes@matriclick.com"
	
	#CONTACT
  def contact_email(contact)
  	@contact = contact
  	mail to: "hola@matriclick.com", subject: "Contacto en Matriclick.com"
  end

	#PURCHASE
  def purchase_email(purchase, country_url_path)
  	@purchase = purchase
  	@purchasable = purchase.purchasable
  	@country_url_path = country_url_path
  	mail to: @purchase.user.email, cc: "vestidos@matriclick.com", subject: "Compra en Matriclick.com"
  end

	#WEDDING PLANNER
  def wedding_planner_email(wedding_planner_quote, action)
  	@wedding_planner_quote = wedding_planner_quote
  	@action = action
  	mail to: "weddingplanner@matriclick.com", subject: action+" cotización Wedding Planner Matriclick.com"
  end
  
  #FEEDBACK
  def feedback_email(feedback)
  	@feedback = feedback
  	mail to: "hola@matriclick.com", subject: "Feedback en Matriclick.com"
  end
  
  #FEEDBACK
  def review_email(review)
  	@review = review
  	@supplier = review.reviewable
  	mail to: "carolina.gaete@matriclick.com", subject: "Review en Matriclick.com"
  end
  
  #PRODUCT
  def product_email(product)
  	@product = product
  	mail to: "carolina.gaete@matriclick.com", subject: "Alerta Precio producto en Matriclick.com"
  end

  #SERVICE
  def service_email(service)
  	@service = service
  	mail to: "carolina.gaete@matriclick.com", subject: "Alerta Precio producto en Matriclick.com"
  end
  
  #REFERENCE
  def reference_request_email(reference_request)
  	@reference_request = reference_request
  	@supplier = reference_request.supplier_account.supplier
  	mail to: "hola@matriclick.com", subject: "Referencias en Matriclick.com"
  end

	# MATRICLICK POINTS
	def matriclick_points_email(user, expense)
		@user = user
		@expense = expense
		mail to: "hola@matriclick.com", subject: "Se registró un gasto para Puntos Matriclick"
	end
  
end
