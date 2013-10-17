class AddFbOrganicReachToWbrData < ActiveRecord::Migration
  def change
    add_column :wbr_data, :fb_organic_reach, :integer
  end
end
