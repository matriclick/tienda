class CreateWbrData < ActiveRecord::Migration
  def change
    create_table :wbr_data do |t|
      t.integer :year
      t.integer :week
      t.integer :fb_followers
      t.integer :webpage_visits
      t.integer :newsletters_sent

      t.timestamps
    end
  end
end
