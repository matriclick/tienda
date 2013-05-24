class CreateCuaVotes < ActiveRecord::Migration
    def change
      create_table :cua_votes do |t|
      t.belongs_to :campaign_user_account_info
      t.belongs_to :user
      t.timestamps
      end
    end
end
