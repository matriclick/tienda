class AddSoldToDresses < ActiveRecord::Migration
  def change
    add_column :dresses, :sold, :boolean, :default => 0
  end
end
