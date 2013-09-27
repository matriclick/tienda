class UpdateAllDressesCosts < ActiveRecord::Migration
  def up
    SupplierAccount.all.each do |sa|
      sa.dresses.each do |d|
        if d.net_cost.blank?
          d.net_cost = d.price - d.price * sa.net_margin/100 * 1.19
          d.save
        end
      end
    end
  end

  def down
  end
end
