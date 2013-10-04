class AddCompetitionIdToContestant < ActiveRecord::Migration
  def change
    add_column :contestants, :competition_id, :integer
  end
end
