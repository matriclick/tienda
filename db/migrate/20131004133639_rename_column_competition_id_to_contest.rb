class RenameColumnCompetitionIdToContest < ActiveRecord::Migration
  def up
    rename_column :contestants, :competition_id, :contest_id
  end

  def down
  end
end
