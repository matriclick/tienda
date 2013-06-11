class AddCreditsUsedToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :credits_used, :float
  end
end
