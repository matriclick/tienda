class AddUnconfirmedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :unconfirmed, :boolean, :default => false
  end
end
