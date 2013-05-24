class CreateCommunes < ActiveRecord::Migration
  def change
    create_table :communes do |t|
      t.string :name
      t.integer :region_id

      t.timestamps
    end
  end
end
