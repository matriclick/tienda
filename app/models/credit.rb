class Credit < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :user
  has_many :credit_reductions
  
  def self.is_active
    where(:active => true)
  end
  
  def available_credit
    if self.credit_reductions.count > 0
      reduction = 0
      self.credit_reductions.each do |red|
        reduction = reduction + red.value
      end
      return self.value - reduction
    else
      return self.value
    end
  end
  
end
