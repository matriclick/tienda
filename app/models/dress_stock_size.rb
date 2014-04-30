class DressStockSize < ActiveRecord::Base
  before_create :set_invalid_stock
	before_update :set_invalid_stock
	before_save :set_invalid_stock
  after_create :set_invalid_stock
	after_update :set_invalid_stock
	after_save :set_invalid_stock
	
  belongs_to :dress
  belongs_to :size
  
  
  def generate_barcode
    #Formato Barcode
    barcode = self.id.to_s
    length = barcode.length
    if length < 12
      (12 - length).times do 
        barcode = '0'+barcode
      end
    end
    puts barcode
    return barcode
  end
  
  def set_invalid_stock
    if self.stock.blank?
      self.stock = 0
      self.save(:validate => false)
    end
  end
  
  def first_with_stock?
    with_stock = []
    self.dress.dress_stock_sizes.each do |dss|
      if dss.stock > 0
        if dss == self
          return true          
        else
          return false         
        end
      end
    end
    return false          
  end
  
end
