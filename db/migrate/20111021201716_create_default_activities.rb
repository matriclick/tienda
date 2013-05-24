class CreateDefaultActivities < ActiveRecord::Migration
  def change
    create_table :default_activities do |t|
      t.string :name
      t.text :description
      t.decimal :weeks_length
      t.integer :position

      t.timestamps
    end
  end
end
