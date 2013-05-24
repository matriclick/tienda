class AddIpToCuaVote < ActiveRecord::Migration
  def change
    add_column :cua_votes, :ip, :string
  end
end
