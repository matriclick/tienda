class GiftCard < ActiveRecord::Base
  after_validation :create_codes, :if => :stock_changed?
  
  has_many :gift_card_codes
  belongs_to :supplier_account
  belongs_to :gift_card_status
  has_and_belongs_to_many :dresses
  
  validates :supplier_account_id, :price, :value, :min_price, :max_price, 
            :stock, :gift_card_status_id, :valid_from, :valid_to, :presence => true
  
  # Creación de códigos
  def create_codes
    count = self.gift_card_codes.count;
    while count < self.stock
      code = (self.id.to_s+(0...10).map{ ('a'..'z').to_a[rand(26)] }.join + count.to_s + self.supplier_account.fantasy_name[0..3]).upcase
      gift_card_code = GiftCardCode.create(:gift_card_id => self.id, :bought => false, :used => false, :code => code)
      self.gift_card_codes << gift_card_code
      count = count + 1
    end
  end
  
  def supplier_image
    to = self.supplier_account.image.url(:smaller).index("?") - 1 
    self.supplier_account.image.url(:smaller)[0..to]
  end
  
  def applies_to_range
    if self.min_price == self.max_price
      false
    else
      true
    end
  end
end
