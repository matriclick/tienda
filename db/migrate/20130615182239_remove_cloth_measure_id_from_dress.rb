class RemoveClothMeasureIdFromDress < ActiveRecord::Migration
  def up
    remove_column :dresses, :cloth_measure_id
  end

  def down
    add_column :dresses, :cloth_measure_id, :integer
  end
end
