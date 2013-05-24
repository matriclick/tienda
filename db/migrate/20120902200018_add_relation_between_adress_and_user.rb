class AddRelationBetweenAdressAndUser < ActiveRecord::Migration
  def up
    create_table :users_addresses, :id => false do |t|
       t.integer :user_id
       t.integer :address_id
       
       t.timestamps
     end
  end

  def down
  end
end
