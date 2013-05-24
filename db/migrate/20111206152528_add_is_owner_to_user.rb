class AddIsOwnerToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_owner, :boolean
  end
end
