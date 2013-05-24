class RenameReadToMessage < ActiveRecord::Migration
  def up
    rename_column :messages, :read, :user_read
  end

  def down
    rename_column :messages, :user_read, :read
  end
end
