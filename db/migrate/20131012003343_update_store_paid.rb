class UpdateStorePaid < ActiveRecord::Migration
  def up
    date = DateTime.new(2013,9,17)
    ShoppingCartItem.all.each do |sci|
      if sci.created_at < date
        sci.store_paid = true
        sci.save(validate: false)
      else      
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
  end

  def down
  end
end
