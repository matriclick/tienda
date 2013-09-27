  # encoding: UTF-8
class ShoppingCartItem < ActiveRecord::Base
  belongs_to :shopping_cart
  has_and_belongs_to_many :store_payments
  
  validate :check_quantity_size
  
  def get_store
    return self.purchasable.supplier_account
  end
  
  def update_costs
    vat = self.purchasable.vat_cost.nil? ? 0 : self.purchasable.vat_cost
    net = self.purchasable.net_cost.nil? ? 0 : self.purchasable.net_cost
    amount = self.quantity.nil? ? 0 : self.quantity
    
    self.update_attribute(:unit_cost => (vat+net))
    self.update_attribute(:unit_cost => (vat+net)*amount)
  end
  
  def update_price
    self.update_attribute(:price => self.purchasable.price)
  end
  
  def check_quantity_size
    case self.purchasable_type
      when 'Dress'
        if !self.quantity.blank? and !self.size.blank?
          matri_size = Size.find_by_name(self.size)
          dress = self.purchasable
          dress_stock_size = DressStockSize.where("size_id = ? and dress_id = ?", matri_size.id, dress.id).first
      
          if self.quantity > dress_stock_size.stock
            errors.add(:cantidad, "Debes seleccionar una cantidad menor. En el item '#{self.purchasable.description.truncate(15)}', habías seleccionado #{self.quantity.to_s} en la talla #{self.size}")
          end
        end
    end
  end
  
  def purchasable
    eval(self.purchasable_type.to_s + '.find ' + self.purchasable_id.to_s)
  end
  
  def enough_stock?
    if self.purchasable_type != 'Dress'
      return true
    else
      if !self.quantity.blank? and !self.size.blank?
        matri_size = Size.find_by_name(self.size)
        dress = self.purchasable
        dress_stock_size = DressStockSize.where("size_id = ? and dress_id = ?", matri_size.id, dress.id).first
        if !(self.quantity > dress_stock_size.stock)
          return true
        end
      end
    end
    return false
  end

end