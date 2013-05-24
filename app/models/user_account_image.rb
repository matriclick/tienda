class UserAccountImage < ActiveRecord::Base
	belongs_to :user_account
	
	has_attached_file :couple, :styles => {:normal => "120x120>"}, :whiny => false
	validates_attachment_content_type :couple, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :couple, :less_than => 2.megabytes
	
end
