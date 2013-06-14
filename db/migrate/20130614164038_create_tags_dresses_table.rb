class CreateTagsDressesTable < ActiveRecord::Migration
  def up
    create_table :tags_dresses, :id => false do |t|
      t.integer :dress_id
      t.integer :tag_id
          
      t.timestamps
    end
  end

  def down
  end
end
