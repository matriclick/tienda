class AddRelatedConfirmToEvent < ActiveRecord::Migration
  def change
    add_column :events, :related_confirm, :boolean, :default => false
  end
end
