class RenameSubscriberPreferencesSubscribers < ActiveRecord::Migration
  def up
    rename_table :subscribers_subscriber_preferences, :subscriber_preferences_subscribers
  end

  def down
  end
end
