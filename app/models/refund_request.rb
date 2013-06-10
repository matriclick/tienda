class RefundRequest < ActiveRecord::Base
  belongs_to :refund_reason
  belongs_to :user
	belongs_to :dress
	
  validates :refund_reason_id, :user_id, :account_owner_name, :account_owner_id, :account_owner_email, :account_bank, :account_type, :account_number, :presence => true
end
