class RenameTableTagsUsers < ActiveRecord::Migration
  def up
    rename_table :users_tags, :tags_users
  end

  def down
    rename_table :tags_users, :users_tags
  end
end
