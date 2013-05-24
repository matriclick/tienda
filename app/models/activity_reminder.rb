class ActivityReminder < ActiveRecord::Base
  belongs_to :activity
  validates :mail, :name, :days_before, :presence => true
  validates :mail, :email =>true
end
