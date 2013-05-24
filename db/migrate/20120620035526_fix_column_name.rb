class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :posts, :content, :introduction
  end

  def down
    rename_column :posts, :introduction, :content
  end
end
