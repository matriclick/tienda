class AddWantsPointsToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :wants_points, :boolean, :default => false
  end
end
