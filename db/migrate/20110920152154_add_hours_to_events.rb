class AddHoursToEvents < ActiveRecord::Migration
  def change
    add_column :events, :starts_at, :time
    add_column :events, :ends_at, :time
  end
end
