class CreateClothMeasures < ActiveRecord::Migration
  def change
    create_table :cloth_measures do |t|
      t.float :bust
      t.float :waist
      t.float :hips

      t.timestamps
    end
  end
end
