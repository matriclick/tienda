class Invitation < ActiveRecord::Base
	has_many :invitees
	belongs_to :user_account
	validates_uniqueness_of :user_account_id
end
