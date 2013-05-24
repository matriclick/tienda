# encoding: UTF-8
class GiftCardCode < ActiveRecord::Base
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
      
  belongs_to :gift_card
  has_one :purchase, :as => :purchasable

  # -------------- PURCHASABLE METHODS -------------------
  def refund
  end

  def price
    self.gift_card.price
  end
  
  def supplier_account
    self.gift_card.supplier_account
  end


  def main_image
    'gift_card/coupon.jpeg'
  end
  
  def description
    
    return "Paga " + number_to_currency(self.gift_card.price).to_s + 
    " por " + number_to_currency(self.gift_card.value).to_s + " en " + self.gift_card.supplier_account.fantasy_name.to_s + ". " + 
    "Canje válido desde el " + self.gift_card.valid_from.strftime("%d %b %Y").to_s + " " + 
    "hasta el " + self.gift_card.valid_to.strftime("%d %b %Y").to_s;
    
  end
  
  def small_image
    'gift_card/coupon_small.jpeg'
  end
  
  def mark_as_sold
    self.bought = true
    self.save
  end
  
  def mark_as_used
    self.used = true
    self.save
  end
  
  # For the methods "link_to_view" and "full_link_to_view", the line "include Rails.application.routes.url_helpers" must be present in the model in order to use the "_path" and "_url" methods.
  def link_to_view(country_url_path, purchase_id = nil)
    gift_cards_show_coupon_path(:id => self.id, :country_url_path => country_url_path)
  end
  
  def full_link_to_view(country_url_path, purchase_id = nil)
    host = 'www.matriclick.com'
    gift_cards_show_coupon_path(:id => self.id, :only_path => false, :host => host, :country_url_path => country_url_path)
  end
  # -------------- END PURCHASABLE METHODS -------------------
  
end
