class ScheduleDayType < ActiveRecord::Base
  has_many :schedule_days, :dependent => :destroy
	has_many :days, :through => :schedule_days
	
	before_validation :ensure_schedule_days_exist
	after_create :set_schedule_type_by_name
	
  private
	def ensure_schedule_days_exist
		if schedule_days.blank? or schedule_days.count < 7
			add_seven_days
		end
	end
  
	def add_seven_days
	    days.clear
      #[DZF 2011/08/23]: This code search the day by his number
			self.days << Day.find_by_day_number(1)
			self.days << Day.find_by_day_number(2)
			self.days << Day.find_by_day_number(3)
			self.days << Day.find_by_day_number(4)
			self.days << Day.find_by_day_number(5)
			self.days << Day.find_by_day_number(6)
			self.days << Day.find_by_day_number(7)
	end
	
	def set_schedule_type_by_name
		if self.name == "Oficina"
			self.schedule_days.find_by_day_id(1).update_attributes(:enabled => true, :from => '2000-01-01 09:00:00 UTC', :to => '2000-01-01 19:00:00 UTC', :start_lunch_time => '2000-01-01 14:00:00 UTC', :end_lunch_time => '2000-01-01 15:00:00 UTC')
			self.schedule_days.find_by_day_id(2).update_attributes(:enabled => true, :from => '2000-01-01 09:00:00 UTC', :to => '2000-01-01 19:00:00 UTC', :start_lunch_time => '2000-01-01 14:00:00 UTC', :end_lunch_time => '2000-01-01 15:00:00 UTC')
			self.schedule_days.find_by_day_id(3).update_attributes(:enabled => true, :from => '2000-01-01 09:00:00 UTC', :to => '2000-01-01 19:00:00 UTC', :start_lunch_time => '2000-01-01 14:00:00 UTC', :end_lunch_time => '2000-01-01 15:00:00 UTC')
			self.schedule_days.find_by_day_id(4).update_attributes(:enabled => true, :from => '2000-01-01 09:00:00 UTC', :to => '2000-01-01 19:00:00 UTC', :start_lunch_time => '2000-01-01 14:00:00 UTC', :end_lunch_time => '2000-01-01 15:00:00 UTC')
			self.schedule_days.find_by_day_id(5).update_attributes(:enabled => true, :from => '2000-01-01 09:00:00 UTC', :to => '2000-01-01 19:00:00 UTC', :start_lunch_time => '2000-01-01 14:00:00 UTC', :end_lunch_time => '2000-01-01 15:00:00 UTC')
			self.schedule_days.find_by_day_id(6).update_attributes(:enabled => false)
			self.schedule_days.find_by_day_id(7).update_attributes(:enabled => false)
		end
	end

end
