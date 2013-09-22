class RefundRequest < ActiveRecord::Base
  belongs_to :refund_reason
  belongs_to :user
	has_and_belongs_to_many :dresses
	
  
  validates :refund_reason_id, :user_id, :account_owner_name, :account_owner_id, :account_owner_email, :account_bank, :account_type, :account_number, :dress_ids, :presence => true
end
