class CreateShoeSizes < ActiveRecord::Migration
  def change
    create_table :shoe_sizes do |t|
      t.string :size_cl
      t.string :size_us

      t.timestamps
    end
  end
end
