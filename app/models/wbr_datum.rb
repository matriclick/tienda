class WbrDatum < ActiveRecord::Base
  validates :year, :week, :fb_followers, :webpage_visits, :newsletters_sent, :presence => true
end
