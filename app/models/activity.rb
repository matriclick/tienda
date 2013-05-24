class Activity < ActiveRecord::Base
  default_scope :order => 'done_by_date'
  
  belongs_to :user_account
  belongs_to :default_activity
  
  has_many :activity_reminders, :dependent => :destroy
  accepts_nested_attributes_for :activity_reminders
  
  before_validation :default_values
  
  # Validations
  validates :name, :done_by_date, :presence => true
  
  def default_values
    if self.default_activity.present?
      if done_by_date.blank?
        deadline = self.user_account.wedding_tentative_date
        position = self.default_activity.position
      
        #Check for all default activities done AFTER the one in analysis
        DefaultActivity.find(:all, :conditions => ['position > ?', position]).each do |act|
          deadline -= act.weeks_length.weeks
        end
              
        self.done_by_date = deadline
        self.name = self.default_activity.name
        self.description = self.default_activity.description
        
        self.save!
      end
    end
  end
  
  def update_done_by_date #DZF using the same algorithm made in the before_validation
		deadline = self.user_account.wedding_tentative_date
    position = self.default_activity.position

    #Check for all default activities done AFTER the one in analysis
    DefaultActivity.find(:all, :conditions => ['position > ?', position]).each do |act|
    	deadline -= act.weeks_length.weeks
    end

    self.done_by_date = deadline
    self.name = self.default_activity.name
    self.description = self.default_activity.description

    self.save!
  end
end
