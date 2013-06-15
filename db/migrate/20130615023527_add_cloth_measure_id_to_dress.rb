class AddClothMeasureIdToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :cloth_measure_id, :integer
  end
end
