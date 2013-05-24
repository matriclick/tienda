class CampaignAnecdoteImage < ActiveRecord::Base
	belongs_to :campaign_anecdote
	
	has_attached_file :anecdote, 
												:styles => {
													:normal => "266x200>",
													:index => "160x120>",
													:tiny => "40x30>"
												}, :whiny => false
	
	validates_attachment_content_type :anecdote, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :anecdote, :less_than => 2.megabytes
	
	# FGM: Get all the images and remove the cover
	def self.without_cover
		images = all
		images.slice!(0)
		images
	end	
end
