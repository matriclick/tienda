class AlbumSetVisibleDefault < ActiveRecord::Migration
  def up
    change_column :album_photos, :visible, :boolean, :default => true
    change_column :albums, :visible, :boolean, :default => true
  end

  def down
  end
end
