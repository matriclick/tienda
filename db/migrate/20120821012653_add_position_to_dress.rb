class AddPositionToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :position, :integer, :default => 99
  end
end
