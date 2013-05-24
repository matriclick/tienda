class ChallengeActivity < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :matriclicker
  belongs_to :challenge_activity_type
  
  validates :challenge_activity_type_id, :presence => true
end
