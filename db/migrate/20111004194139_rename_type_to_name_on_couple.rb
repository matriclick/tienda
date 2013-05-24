class RenameTypeToNameOnCouple < ActiveRecord::Migration
  def up
    rename_column :couples, :type,:name
  end

  def down

  end
end

