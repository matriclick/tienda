class AddWatchToEvents < ActiveRecord::Migration
  def change
    add_column :events, :watch, :boolean, :default => true
  end
end
