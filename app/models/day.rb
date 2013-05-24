class Day < ActiveRecord::Base
  has_many :schedule_days
  has_many :schedules, :through => :schedule_days
end
