class ScheduleDay < ActiveRecord::Base
  belongs_to :day
  belongs_to :schedule
  belongs_to :schedule_day_type
end
