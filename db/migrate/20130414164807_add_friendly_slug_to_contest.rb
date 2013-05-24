class AddFriendlySlugToContest < ActiveRecord::Migration
  def change
    add_column :contest_travelites, :slug, :string
    add_index :contest_travelites, :slug, unique: true
    
    ContestTravelite.find_each(&:save)
  end
end
