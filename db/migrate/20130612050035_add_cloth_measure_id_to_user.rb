class AddClothMeasureIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :cloth_measure_id, :integer
  end
end
