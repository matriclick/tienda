class Message < ActiveRecord::Base
	after_create :send_email_to_receptor

	belongs_to :conversation
	has_many :attached_files, :as => :attachable

	validates :content, :presence => true
	
	accepts_nested_attributes_for :attached_files, :reject_if => proc { |a| a[:attached].blank? }, :allow_destroy => true

  def self.supplier_unread
  	where(:supplier_read => [false, nil])
  end

	def self.user_unread
		where(:user_read => [false, nil])
	end

	def send_email_to_receptor #DZF es necesario conseguir eficazmente el User que corresponda desde el message
  	if self.conversation.supplier_account.corporate_name != self.transmitter
  		SupplierMailer.message_email_to_supplier(self, self.conversation.user).deliver
  	else
  		UserMailer.supplier_respond_message_email(self, self.conversation.user).deliver
  	end
  end
end
