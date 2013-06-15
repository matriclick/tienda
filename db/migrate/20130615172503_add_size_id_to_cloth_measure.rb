class AddSizeIdToClothMeasure < ActiveRecord::Migration
  def change
    add_column :cloth_measures, :size_id, :integer
  end
end
