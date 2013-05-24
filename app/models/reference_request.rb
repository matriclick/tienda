class ReferenceRequest < ActiveRecord::Base
	belongs_to :product
	belongs_to :service
	belongs_to :user
	belongs_to :supplier_account
	belongs_to :supplier
	
	after_create :reference_request_email
	
	def reference_request_email
 		NoticeMailer.reference_request_email(self).deliver
	end
end
