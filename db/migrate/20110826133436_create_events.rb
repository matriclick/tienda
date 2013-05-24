class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :place_id
      t.string :title
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :all_day
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
