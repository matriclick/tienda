class Matriclicker < ActiveRecord::Base
  has_many :contracts
  has_many :leads
  has_many :challenges
  has_many :challenge_activities
  belongs_to :user
  belongs_to :matriclicker_status
  has_and_belongs_to_many :privileges
  
  def self.active
	  where(:matriclicker_status_id => MatriclickerStatus.find_by_name("Activo").id) 
  end
end
