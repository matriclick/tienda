class ClothMeasure < ActiveRecord::Base
  belongs_to :shoe_size
  has_one :user
  has_one :dress
  
end
