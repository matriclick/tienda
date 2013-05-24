# encoding: UTF-8
class ShoppingCartItem < ActiveRecord::Base
  belongs_to :shopping_cart
  
  validate :check_quantity_size
  
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
  
  def price
    if !self.quantity.blank?
      price = self.purchasable.price * self.quantity
    else
      price = self.purchasable.price
    end
    return price
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