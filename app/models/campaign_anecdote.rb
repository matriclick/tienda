class CampaignAnecdote < ActiveRecord::Base
	# FGM: Needed for ratings
	has_many :star_ratings, :as => :rateable, :dependent => :destroy
	
	has_many :campaign_anecdote_images, :dependent => :destroy
	
	accepts_nested_attributes_for :campaign_anecdote_images, :reject_if => proc { |a| a[:anecdote].blank? }, :allow_destroy => true
	
	validates :description, :title, :presence => true
	
	accepts_nested_attributes_for :star_ratings, :reject_if => lambda { |a| a[:value].blank? }, :allow_destroy => true
	
	extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :i18n]
	
	# FGM: Needed for ratings
	def rating_total
		star_ratings.sum('star_ratings.value')
	end
	
	# FGM: Needed for ratings
	def rating_average
		rating_total / self.star_ratings.count.to_f
	end
	
	# FGM: Needed for ratings
	def voted_by_user?(user)
		star_ratings.where(user_id: user.id).present?
	end
end
