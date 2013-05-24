class CreateColorType < ActiveRecord::Migration
  def change
    create_table :color_types do |t|
      t.string :name
      t.string :hex
      
      t.timestamps
    end
  end
end
