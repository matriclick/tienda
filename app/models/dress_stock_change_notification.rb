class DressStockChangeNotification < ActiveRecord::Base
  belongs_to :dress
  belongs_to :size
  
	validates :dress, :email, :size, :presence => true
end
