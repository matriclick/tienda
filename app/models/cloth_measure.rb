class ClothMeasure < ActiveRecord::Base
  validates :bust, :waist, :hips, :presence => true
end
