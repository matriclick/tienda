class ChangeUserIdForEmailForDressNotifications < ActiveRecord::Migration
  def up
    add_column :dress_stock_change_notifications, :email, :string
    remove_column :dress_stock_change_notifications, :user_id
  end

  def down
  end
end
