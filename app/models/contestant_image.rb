class ContestantImage < ActiveRecord::Base
	belongs_to :contestant
	
	has_attached_file :image, 
												:styles => {
													:main => "300x",
													:side => "70x",
													:index_dress => "190x"
												}, :whiny => false
                        
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :image, :less_than => 2.megabytes
  
end
