class DefaultActivity < ActiveRecord::Base
  default_scope :order => 'position'
  
  has_many :activities, :dependent => :destroy
  
end
