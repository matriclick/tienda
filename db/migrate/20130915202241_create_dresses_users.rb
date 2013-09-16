class CreateDressesUsers < ActiveRecord::Migration
  def up
    create_table :dresses_users, :id => false do |t|
      t.integer :dress_id
      t.integer :user_id
          
      t.timestamps
    end
  end

  def down
  end
end
