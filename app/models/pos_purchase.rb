# encoding: UTF-8
class PosPurchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :shopping_cart
  
  def self.to_csv(from, to, supplier_account)
    pos_purchases = PosPurchase.where('created_at >= ? and created_at <= ? and supplier_account_id = ?', from, to, supplier_account.id).order 'created_at DESC'
    header = ['Fecha Creación', 'Monto', 'Artículos Comprados', 'Medio de Pago', 'Vendedor']
    
    CSV.generate do |csv|
      csv << header
      pos_purchases.each do |pos_purchase|
        csv << [pos_purchase.created_at, 
              pos_purchase.price, 
              pos_purchase.shopping_cart.products_quantity, 
              !pos_purchase.payment_method.blank? ? pos_purchase.payment_method.gsub('_',' ').capitalize : '',
              pos_purchase.user.email]
      end
    end
  end  
  
end
