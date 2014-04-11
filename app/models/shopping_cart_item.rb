  # encoding: UTF-8
class ShoppingCartItem < ActiveRecord::Base
  belongs_to :shopping_cart
  has_and_belongs_to_many :store_payments
    
  def has_stock?
    size = Size.find_by_name(self.size)
    dress_stock_size = DressStockSize.where("size_id = ? and dress_id = ? and color = ?", size.id, self.purchasable_id, self.color).first
    
    
    if dress_stock_size.nil? or self.quantity.nil?
      return false
    else
      return dress_stock_size.stock >= self.quantity ? true : false
    end
  end
  
  def get_store
    return self.purchasable.supplier_account
  end
  
  def update_costs
    vat = self.purchasable.vat_cost.nil? ? 0 : self.purchasable.vat_cost
    net = self.purchasable.net_cost.nil? ? 0 : self.purchasable.net_cost
    amount = self.quantity.nil? ? 0 : self.quantity
    
    self.update_attribute(:unit_cost, (vat+net))
    self.update_attribute(:total_cost, (vat+net)*amount)
  end
  
  def update_price
    self.update_attribute(:price, self.purchasable.price)
  end
  
  def purchasable
    begin
      @object = eval(self.purchasable_type.to_s + '.find ' + self.purchasable_id.to_s)
    rescue Exception => exc
      @object = nil
    end
    return @object
  end
  
end