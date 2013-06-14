class ChangeTableNameToDressesTags < ActiveRecord::Migration
  def up
    rename_table :tags_dresses, :dresses_tags
  end

  def down
    rename_table :dresses_tags, :tags_dresses
  end
end
