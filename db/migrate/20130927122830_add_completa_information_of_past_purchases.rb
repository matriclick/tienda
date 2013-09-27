class AddCompletaInformationOfPastPurchases < ActiveRecord::Migration
  def up
    ShoppingCartItem.all.each do |sci|
      if !sci.quantity.blank?
        puts sci.id
        sci.update_price if sci.price.blank?
        sci.update_costs if sci.unit_cost.blank? or sci.unit_cost == 0
        sci.store_paid = true
        sci.save
      end
    end
  end

  def down
  end
end
