class CampaignGalleryItem < ActiveRecord::Base
	has_many :campaign_gallery_item_images, :dependent => :destroy
	
	accepts_nested_attributes_for :campaign_gallery_item_images, :reject_if => proc { |a| a[:gallery_item].blank? }, :allow_destroy => true
	
	validates :description, :tag, :presence => true
end
