class UpdatePaidItemsByStore < ActiveRecord::Migration
  def up
    Purchase.all.each do |p|
      puts p.created_at
      if p.purchasable_type == 'Dress'
        unless p.purchasable.blank?
          if p.purchasable.supplier_account.fantasy_name == 'Pajarita Boutique'
            p.store_paid = false
            p.save
          end
        end
      else
        unless p.purchasable.blank?
          p.purchasable.shopping_cart_items.each do |sci|
            if sci.purchasable.supplier_account.fantasy_name == 'Pajarita Boutique'
              sci.store_paid = false
              sci.save
            end
          end
        end
      end
    end
  end

  def down
  end
end
