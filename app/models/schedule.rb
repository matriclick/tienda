class Schedule < ActiveRecord::Base
  belongs_to :service  
  has_many :schedule_days, :dependent => :destroy
  has_many :days, :through => :schedule_days

  before_validation :ensure_schedule_days_exist
  accepts_nested_attributes_for :schedule_days
  
	def has_enabled_days?
		schedule_days.blank? ? (return true) : (schedule_days.each { |sd| return true if sd.enabled })
		false
	end

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
end

