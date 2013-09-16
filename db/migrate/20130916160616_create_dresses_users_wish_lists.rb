class CreateDressesUsersWishLists < ActiveRecord::Migration
  def change
    create_table :dresses_users_wish_lists do |t|
      t.integer :dress_id
      t.integer :user_id

      t.timestamps
    end
  end
end
