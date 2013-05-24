class CreateDresses < ActiveRecord::Migration
  def change
    create_table :dresses do |t|
      t.string :description
      t.integer :price

      t.timestamps
    end
  end
end
