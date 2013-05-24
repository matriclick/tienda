class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :videoable_type
      t.integer :videoable_id
      t.string :url_code

      t.timestamps
    end
  end
end
