class AddStatusToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :status, :string, :default => 'inicial'
  end
end
