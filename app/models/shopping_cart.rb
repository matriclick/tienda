# encoding: UTF-8
class ShoppingCart < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  belongs_to :user
  has_many :shopping_cart_items
  
  def net_cost
    aux = 0
    self.shopping_cart_items.each do |sci|
      aux = aux + sci.purchasable.net_cost
    end
    return aux
  end
  
  def vat_cost
    aux = 0
    self.shopping_cart_items.each do |sci|
      aux = aux + sci.purchasable.vat_cost
    end
    return aux
  end
  
  def self.is_active
    where(:active => true)
  end
    
  # -------------- PURCHASABLE METHODS -------------------  
  def price
    price = 0
    self.shopping_cart_items.each do |shopping_cart_item|
      shopping_cart_item.update_price
    	price = price + shopping_cart_item.price*shopping_cart_item.quantity
  	end
  	return price
  end
  
  def main_image
    'shopping_cart/cart-big.jpeg'
  end
  
  def description
    aux = ''
    self.shopping_cart_items.each do |sci|
      aux = '- '+sci.purchasable.introduction+'<br />'+aux
    end
    return 'CARRITO DE COMPRAS<br />'+aux
  end
  
  def supplier_account
    nil
  end
  
  def refund
  end
  
  def small_image
    'shopping_cart/cart-small.jpeg'  
  end
  
  def mark_as_sold
    self.active = false
    self.save
    self.shopping_cart_items.each do |shopping_cart_item|
      object = shopping_cart_item.purchasable
      case object.class.to_s
        when 'Dress'
          object.mark_as_sold(shopping_cart_item.size, shopping_cart_item.quantity)
          shopping_cart_item.update_price
          shopping_cart_item.update_costs
          shopping_cart_item.save
        else
          object.mark_as_sold
      end
    end
  end
  
  def mark_as_used
  end
  
  # For the methods "link_to_view" and "full_link_to_view", the line "include Rails.application.routes.url_helpers" must be present in the model in order to use the "_path" and "_url" methods.
  def link_to_view(purchase_id = nil)
    purchases_show_for_user_path(:id => purchase_id)
  end
  
  def full_link_to_view(purchase_id = nil)
    host = 'www.tramanta.com'
    
    purchases_show_for_user_path(:only_path => false, :host => host, :id => purchase_id)
  end
  # -------------- END PURCHASABLE METHODS -------------------
  
  
end
