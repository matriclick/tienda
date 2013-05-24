class SubscriberPreference < ActiveRecord::Base
  has_and_belongs_to_many :subscribers
end
