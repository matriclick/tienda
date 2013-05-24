class CampaignUserAccountInfo < ActiveRecord::Base
	belongs_to :user_account
	has_many :cua_votes, :dependent => :destroy
	
	has_attached_file :campaign_user_image, 
												:styles => {
													:big => "400x300>",
													:huge => "800x600>",
													:index => "160x120>",
													:tiny => "40x30>"
												}, :whiny => false
	
	validates_attachment_content_type :campaign_user_image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :campaign_user_image, :less_than => 2.megabytes
	validates :description, :presence => true, :length => {:maximum => 800}, :unless => :campaign_user_image_exists
	
	after_save :set_user_account_in_campaign
	
	def self.approved
		where(:approved_by_us => true)
  end

  def self.best_voted_ids(int = 10)
    approved.joins(:cua_votes).group('cua_votes.campaign_user_account_info_id').count.sort_by {|k,v| v}.reverse[0..(int-1)].collect{|x| x[0]}
    end

  def self.best_voted(int = 10)
    array = []
    best_voted_ids.each do |id|
    array << CampaignUserAccountInfo.find(id)
    end
    array
  end
	
	private
	def set_user_account_in_campaign
		if description.blank?
			self.user_account.update_attribute(:in_campaign, false)
			self.destroy
		else
			self.user_account.update_attribute(:in_campaign, true)
		end
		
	end
	
	def campaign_user_image_exists
		campaign_user_image.url.include? "missing"
	end
end
