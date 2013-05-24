class Rock < ActiveRecord::Base
	belongs_to :gender
	
	validates :sender_name, :sender_email, :recipient_name, :recipient_email, :gender_id, :presence => true
	validates :sender_email, :recipient_email, :email => true
end