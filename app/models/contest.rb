class Contest < ActiveRecord::Base
  extend FriendlyId
  
  friendly_id :name, use: :slugged
	
  has_attached_file :image, 
												:styles => {
													:xl => "1140x",
													:l => "500x",
													:m => "300x",
                          :s => "150x",
                          :xs => "50x"
												}, :whiny => false
  
  has_many :contestants, :dependent => :destroy
end
