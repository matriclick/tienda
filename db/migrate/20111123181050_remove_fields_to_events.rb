class RemoveFieldsToEvents < ActiveRecord::Migration
  def up
  	remove_column :events, :all_day
  	remove_column :events, :starts_at
  	remove_column :events, :ends_at
  	remove_column :events, :personal_event
  	add_column :events, :email, :string
  end

  def down
  	add_column :events, :all_day, :boolean
  	add_column :events, :starts_at, :time
  	add_column :events, :ends_at, :time
  	add_column :events, :personal_event, :boolean
  	remove_column :events, :email
  end
end
