class ChangeEvents < ActiveRecord::Migration
  def up
    remove_column :events, :starts_at
    remove_column :events, :ends_at
    add_column :events, :date, :date
    add_column :events, :personal_event, :boolean
  end

  def down
    add_column :events, :starts_at, :datetime
    add_column :events, :ends_at, :datetime
    remove_column :events, :date
    remove_column :events, :personal_event
  end
end
