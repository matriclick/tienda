class RemoveHexFromColorType < ActiveRecord::Migration
  def up
		remove_column :color_types, :hex
  end

  def down
		add_column :color_types, :hex, :string
  end
end
