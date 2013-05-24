class AddFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :booking_confirmed, :boolean
    add_column :events, :user_account_id, :integer
  end
end
