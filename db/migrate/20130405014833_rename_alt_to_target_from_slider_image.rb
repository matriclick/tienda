class RenameAltToTargetFromSliderImage < ActiveRecord::Migration
  def up
    rename_column :slider_images, :alt, :target
  end

  def down
  end
end
