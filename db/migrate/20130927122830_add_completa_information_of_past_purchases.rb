class AddCompletaInformationOfPastPurchases < ActiveRecord::Migration
  def up
    ShoppingCartItem.all.each do |sci|
      if !sci.quantity.blank?
        puts sci.id
        sci.update_price if sci.price.blank?
        puts sci.price 
        sci.update_costs if sci.unit_cost.blank? or sci.unit_cost == 0
        puts sci.unit_cost
        sci.store_paid = true
        puts sci.store_paid
        sci.save(:validate => false)
        puts '********'
      end
    end
  end

  def down
  end
end
