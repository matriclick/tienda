# encoding: UTF-8
class Purchase < ActiveRecord::Base
  before_create :check_quantity_size
  
  has_one :order, :dependent => :destroy
  belongs_to :user
  belongs_to :delivery_info
  belongs_to :purchasable, :polymorphic => true
  belongs_to :logistic_provider
  
  has_many :credits, :dependent => :destroy
  has_many :credit_reductions, :dependent => :destroy
  
  belongs_to :delivery_method
  
  validates :purchasable_id, :purchasable_type, :user_id, :price, :currency, :confirmed_terms, :delivery_cost, :presence => true
  validate :check_if_delivery_info_required
    
    
  def products_in_purchase_price
    if self.purchasable_type == 'Dress'
      return self.purchasable.price
    else
      amount = 0
      self.purchasable.shopping_cart_items.each do |sci|
        amount = amount + sci.purchasable.price
      end
      return amount
    end
  end
  
  def store_payment_amount
    if self.purchasable_type == 'Dress'
      return self.purchasable.net_cost
    else
      amount = 0
      self.purchasable.shopping_cart_items.each do |sci|
        amount = amount + sci.purchasable.net_cost
      end
      return amount
    end
  end
  
  def total_credit_reductions
    total = 0
    self.credit_reductions.each do |credit_reduction|
      total = total + credit_reduction.value
    end
    return total
  end
  
  def dispatch_cost
    self.delivery_cost
  end
  
  def check_if_delivery_info_required
    if %w[Dress ShoppingCart].include?(self.purchasable_type)
        errors.add(:delivery_info_id, "Debes entregar una dirección de despacho") if self.delivery_info_id.nil?
    end
  end

  def check_quantity_size
    case self.purchasable_type
      when 'Dress'
        if !self.quantity.blank? and !self.size.blank?
          matri_size = Size.find_by_name(self.size)
          dress = self.purchasable
          dress_stock_size = DressStockSize.where("size_id = ? and dress_id = ?", matri_size.id, dress.id).first
      
          if self.quantity > dress_stock_size.stock
            errors.add(:quantity, "Debes seleccionar una talla y cantidad según la disponibilidad")
          end
        else
          errors.add(:Selection, "Debes seleccionar una talla y cantidad")
        end
    end
  end
  
end
