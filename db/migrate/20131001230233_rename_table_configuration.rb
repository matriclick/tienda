class RenameTableConfiguration < ActiveRecord::Migration
  def up
    rename_table :configurations, :site_configurations
  end

  def down
  end
end
