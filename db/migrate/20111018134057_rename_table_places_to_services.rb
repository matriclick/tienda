class RenameTablePlacesToServices < ActiveRecord::Migration
  def up
    rename_table :places, :services
  end

  def down
  end
end
