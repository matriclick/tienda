class CampaignGalleryItemImage < ActiveRecord::Base
	belongs_to :campaign_gallery_item
	has_attached_file :gallery_item, 
												:styles => {
													:big => "400x300>",
													:index => "160x120>",
													:tiny => "40x30>"
												}, :whiny => false
	
	validates_attachment_content_type :gallery_item, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :gallery_item, :less_than => 2.megabytes
	
	# FGM: Get all the images and remove the cover
	def self.without_cover
		images = all
		images.slice!(0)
		images
	end	
end
