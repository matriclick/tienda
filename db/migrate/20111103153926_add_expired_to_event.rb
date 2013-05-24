class AddExpiredToEvent < ActiveRecord::Migration
  def change
    add_column :events, :expired, :boolean
  end
end
