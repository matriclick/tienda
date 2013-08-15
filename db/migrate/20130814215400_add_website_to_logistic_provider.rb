class AddWebsiteToLogisticProvider < ActiveRecord::Migration
  def change
    add_column :logistic_providers, :website, :string
  end
end
