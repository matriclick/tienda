class CreateDressRequests < ActiveRecord::Migration
  def change
    create_table :dress_requests do |t|
      t.integer :dress_id
      t.integer :user_id

      t.timestamps
    end
  end
end
