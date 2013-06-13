class ClothMeasure < ActiveRecord::Base
  belongs_to :shoe_size
  validates :bust, :waist, :hips, :shoe_size_id,:presence => true
end
