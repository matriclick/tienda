class RenameTablePlaceimagesToServiceimages < ActiveRecord::Migration
  def up
    rename_table :place_images, :service_images
  end

  def down
  end
end
