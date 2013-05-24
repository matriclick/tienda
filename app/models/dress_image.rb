class DressImage < ActiveRecord::Base
	belongs_to :dress
	
	has_attached_file :dress, 
												:styles => {
													:main => "300x",
													:side => "70x",
													:index_dress => "190x",
													:index_accesory => "250x",
													:tiny => "40x"
												}, :whiny => false
	validates_attachment_content_type :dress, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :dress, :less_than => 2.megabytes
	
	# FGM: Get all the images and remove the cover
	def self.without_cover
		images = all
		images.slice!(0)
		images
	end	
	
	def name
	  file_name = self.dress_file_name
	  return file_name[0..file_name.index('.')-1].gsub('-', ' ')
  end
end
