class CreateUsersTags < ActiveRecord::Migration
  def up
    create_table :users_tags, :id => false do |t|
      t.integer :user_id
      t.integer :tag_id
          
      t.timestamps
    end
  end

  def down
  end
end
