class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.text :comments
      t.date :done_by_date
      t.boolean :done
      t.integer :default_activity_id
      t.integer :user_account_id

      t.timestamps
    end
  end
end
