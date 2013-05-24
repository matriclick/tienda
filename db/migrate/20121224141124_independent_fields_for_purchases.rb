# encoding: UTF-8
class IndependentFieldsForPurchases < ActiveRecord::Migration
  def up
    unless column_exists? :purchases, :dispatch_cost
      add_column :purchases, :dispatch_cost, :integer
    end
    unless column_exists? :purchases, :dispatch_address
      add_column :purchases, :dispatch_address, :string
    end
    
    purchases = Purchase.all
    purchases.each do |purchase|
      if purchase.status == 'finalizado' and !purchase.delivery_info.nil?
        purchase.dispatch_address = purchase.delivery_info.street + ' ' + purchase.delivery_info.number
        purchase.dispatch_address = purchase.dispatch_address +  ', depto/casa ' + purchase.delivery_info.apartment if !purchase.delivery_info.apartment.blank?
        purchase.dispatch_address = purchase.dispatch_address +  ', ' + purchase.delivery_info.commune.name if !purchase.delivery_info.commune.nil?
        purchase.dispatch_address = purchase.dispatch_address +  ', ' + purchase.delivery_info.commune.region.name if !purchase.delivery_info.commune.region.nil?
        if purchase.created_at < '2012-12-21 01:03:03'
          purchase.dispatch_cost = 0
        else
          purchase.dispatch_cost = purchase.delivery_info.commune.dispatch_cost if !purchase.delivery_info.commune.nil?
        end
      end
      purchase.save(:validate => false)
    end
  end

  def down
    remove_column :purchases, :dispatch_cost
    remove_column :purchases, :dispatch_address
  end
end
