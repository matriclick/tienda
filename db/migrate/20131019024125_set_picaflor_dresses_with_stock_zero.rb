class SetPicaflorDressesWithStockZero < ActiveRecord::Migration
  def up
    sa = SupplierAccount.where('fantasy_name like "%picaflor%"').first
    unless sa.nil?
      sa.dresses do |d|
        d.dress_stock_sizes.each do |dsz|
          dsz.stock = 0
          dsz.save
        end
        d.status = DressStatus.where('name = "Vendido y Oculto"').first
        puts d.introduction
        d.save 
      end
    end
  end

  def down
  end
end
