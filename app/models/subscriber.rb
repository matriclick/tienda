class Subscriber < ActiveRecord::Base
  has_and_belongs_to_many :subscriber_preferences
	belongs_to :commune
	
  validates :email, :email => true, :presence => true
  
end
