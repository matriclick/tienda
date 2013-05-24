class MatriReminder
  def self.activity_reminder_email
    ActivityReminder.where("sent IS NULL OR sent = 0").each do |activity_reminder|
      if activity_reminder.activity.done_by_date - activity_reminder.days_before == Date.today
        if UserMailer.reminder_email(activity_reminder).deliver
          activity_reminder.update_attributes!(:sent => true)
        end
      end
    end
  end
	
end
