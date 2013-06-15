class ClothMeasure < ActiveRecord::Base
  belongs_to :shoe_size
  belongs_to :size
  has_one :user
  has_and_belongs_to_many :dresses
  
  def dress
    self.dresses.first
  end
end
