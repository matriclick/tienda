class AddSoftDeletedToEvent < ActiveRecord::Migration
  def change
    add_column :events, :soft_deleted, :boolean, :default => false
  end
end
