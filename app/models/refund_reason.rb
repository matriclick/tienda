class RefundReason < ActiveRecord::Base
  has_many :refund_requests, :dependent => :destroy

  validates :name, :presence => true
end
