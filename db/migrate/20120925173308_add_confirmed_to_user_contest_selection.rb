class AddConfirmedToUserContestSelection < ActiveRecord::Migration

  def self.up
    add_column :user_contest_selections, :confirmed, :boolean
  end
 
  def self.down
    remove_column :user_contest_selections, :confirmed
  end

end
