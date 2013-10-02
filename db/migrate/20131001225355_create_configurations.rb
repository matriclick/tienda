class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.boolean :clearance_menu

      t.timestamps
    end
  end
end
