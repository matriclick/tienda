class CreateSubscriberToSubscriberPreferences < ActiveRecord::Migration
  def up
    create_table :subscribers_subscriber_preferences, :id => false do |t|
       t.integer :subscriber_id
       t.integer :subscriber_preference_id

       t.timestamps
     end
  end

  def down
  end
end
