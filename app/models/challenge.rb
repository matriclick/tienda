class Challenge < ActiveRecord::Base
  has_many :challenge_activities, :dependent => :destroy
  belongs_to :lead
  belongs_to :matriclicker
end
