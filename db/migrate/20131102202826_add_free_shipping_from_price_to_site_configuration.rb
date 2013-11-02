class AddFreeShippingFromPriceToSiteConfiguration < ActiveRecord::Migration
  def change
    add_column :site_configurations, :free_shipping_from_price, :integer
  end
end
