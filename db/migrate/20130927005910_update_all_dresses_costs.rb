class UpdateAllDressesCosts < ActiveRecord::Migration
  def up
    SupplierAccount.all.each do |sa|
      sa.dresses.each do |d|
        if d.net_cost.blank?
          d.net_cost = d.price.to_f - d.price.to_f * sa.net_margin.to_f/100 * 1.19 if !d.price.blank? and !sa.net_margin.blank?
          puts '****'
          puts d.introduction
          puts d.net_cost
          puts '****'
          d.save
        end
      end
    end
  end

  def down
  end
end
