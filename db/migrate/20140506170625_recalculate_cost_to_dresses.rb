class RecalculateCostToDresses < ActiveRecord::Migration
  def up
    dresses = Dress.where('created_at > "2014-04-29"')
    dresses.each do |dress|
      dress.update_attribute :net_cost, dress.price - (dress.price.to_f * dress.supplier_account.net_margin.to_f*1.19/100).ceil
    end
  end

  def down
  end
end
