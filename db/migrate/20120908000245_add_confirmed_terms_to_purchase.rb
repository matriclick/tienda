class AddConfirmedTermsToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :confirmed_terms, :boolean
  end
end
