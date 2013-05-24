# encoding: UTF-8
class MailInline
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :dress_id, :dress_url, :dress_image_url, :sender_name, :sender_last_name, :recipient_email, :message

  validates_presence_of :dress_id, :dress_url, :dress_image_url, :sender_name, :sender_last_name, :recipient_email
  validates_format_of :recipient_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end