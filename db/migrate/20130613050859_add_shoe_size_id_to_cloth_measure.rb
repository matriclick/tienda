class AddShoeSizeIdToClothMeasure < ActiveRecord::Migration
  def change
    add_column :cloth_measures, :shoe_size_id, :integer
  end
end
