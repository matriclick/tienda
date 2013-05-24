class CreateSubscriberPreferences < ActiveRecord::Migration
  def change
    create_table :subscriber_preferences do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
