class Feedback < ActiveRecord::Base
  after_create :send_feedback_email
  
  def send_feedback_email
    NoticeMailer.feedback_email(self).deliver
  end
end
