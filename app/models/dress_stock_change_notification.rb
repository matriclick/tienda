class DressStockChangeNotification < ActiveRecord::Base
  belongs_to :dress
  belongs_to :size
end
