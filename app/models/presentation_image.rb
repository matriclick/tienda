class PresentationImage < ActiveRecord::Base
	belongs_to :presentation
	has_attached_file :image, 
											:styles => {
												:thumb => "100x100>",
												:smaller => "120x90>",
												:small => "200x150>",
												:tiny => "40x40>"
											}, :whiny => false
											
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :image, :less_than => 2.megabytes
end
