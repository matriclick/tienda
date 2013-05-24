class Contact < ActiveRecord::Base
  after_create :send_contact_email
  
  def send_contact_email
    NoticeMailer.contact_email(self).deliver
  end
end
