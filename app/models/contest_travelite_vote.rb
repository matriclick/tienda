class ContestTraveliteVote < ActiveRecord::Base
  belongs_to :contest_travelite
  
  validates :contest_travelite_id, :presence => true
  validates :selection, :presence => true
  
  validates :user_id, :presence => true
  validates :user_id, :uniqueness => true
  
  validates_uniqueness_of :user_id, :scope => :selection
  
end
