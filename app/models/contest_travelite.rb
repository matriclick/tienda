class ContestTravelite < ActiveRecord::Base
  extend FriendlyId
  friendly_id :bride_name, use: :slugged
  
  belongs_to :user
  has_many :contest_travelite_votes

  has_attached_file :contest_travelite_image, 
  									  :styles => {
  									    :contest_travelite_size => "220x",
  									    :contest_travelite_big => "500x"
  }, :whiny => false
  validates_attachment_content_type :contest_travelite_image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
  validates_attachment_size :contest_travelite_image, :less_than => 10.megabytes

  validates :selection, :presence => true
  validates :user_id, :presence => true
  validates :bride_name, :presence => true
  validates :photo_name, :presence => true
    
  validates_uniqueness_of :user_id, :scope => :selection
  
end
