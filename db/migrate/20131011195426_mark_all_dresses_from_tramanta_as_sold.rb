class MarkAllDressesFromTramantaAsSold < ActiveRecord::Migration
  def up
    ShoppingCartItem.all.each do |sci|
      unless sci.purchasable.nil?
        unless sci.purchasable.supplier_account.nil?
          if sci.purchasable.supplier_account.fantasy_name == 'Tramanta'
            sci.store_paid = true
            sci.save(validate: false)
          end
        end
      end
    end
  end

  def down
  end
end
