class UpdateSciCostAndPrice < ActiveRecord::Migration
  def up
    ShoppingCartItem.all.each do |sci|
      if !Dress.where(id: sci.purchasable_id).nil?
        vat = sci.purchasable.vat_cost.nil? ? 0 : sci.purchasable.vat_cost
        net = sci.purchasable.net_cost.nil? ? 0 : sci.purchasable.net_cost
        amount = sci.quantity.nil? ? 0 : sci.quantity
    
        sci.total_cost = (vat+net)*amount
        sci.unit_cost = (vat+net)
        sci.price = sci.purchasable.price
        sci.save
      else
        sci.destroy 
      end
    end
  end

  def down
  end
end
