class CreateAlbumPhotos < ActiveRecord::Migration
  def change
    create_table :album_photos do |t|
      t.string :name
      t.string :description
      t.integer :album_id
      t.boolean :visible

      t.timestamps
    end
  end
end
