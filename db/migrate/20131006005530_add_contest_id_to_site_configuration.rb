class AddContestIdToSiteConfiguration < ActiveRecord::Migration
  def change
    add_column :site_configurations, :contest_id, :integer
  end
end
