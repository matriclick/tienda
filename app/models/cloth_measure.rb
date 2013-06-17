class ClothMeasure < ActiveRecord::Base
  belongs_to :shoe_size
  belongs_to :size
  has_one :user
  has_and_belongs_to_many :dresses
  
  def dress
    self.dresses.first
  end
  
  #array_tolerance tiene que venir con el fomato [:bust => X1, :waist => X2, :hips => X3, :ShoeSize => X4]
  def similar_to(cloth_measure, array_tolerance)    
    bust_match = false
    waist_match = false
    hips_match = false
    shoe_size_match = false
     
    if cloth_measure.bust.nil? or self.bust.nil? or ClothMeasure.check_match(self.bust, cloth_measure.bust, array_tolerance[:bust])
      bust_match = true
    end
    if cloth_measure.waist.nil? or self.waist.nil? or ClothMeasure.check_match(self.waist, cloth_measure.waist, array_tolerance[:waist])
      waist_match = true
    end
    if cloth_measure.hips.nil? or self.hips.nil? or ClothMeasure.check_match(self.hips, cloth_measure.hips, array_tolerance[:hips])
      hips_match = true
    end
    if cloth_measure.shoe_size.nil? or self.shoe_size.nil? or 
      ClothMeasure.check_match(self.shoe_size.size_cl, cloth_measure.shoe_size.size_cl, array_tolerance[:shoe_size])
      shoe_size_match = true
    end
    
    if bust_match and waist_match and hips_match and shoe_size_match
      return true
    else
      return false
    end
  end

  def self.check_match(number1, number2, tolerance = 0)
    diference = (number1 - number2).abs
    if tolerance >= diference
      return true
    end
    return false
  end
  
end
