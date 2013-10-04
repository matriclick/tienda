class CreateContestantImages < ActiveRecord::Migration
  def change
    create_table :contestant_images do |t|
      t.integer :contestant_id
      t.string :name
      
      t.timestamps
    end
    add_attachment :contestant_images, :image
  end
end
