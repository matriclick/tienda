class AddLogisticProviderIdToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :logistic_provider_id, :integer
  end
end
