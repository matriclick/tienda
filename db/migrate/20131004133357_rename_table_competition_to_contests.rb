class RenameTableCompetitionToContests < ActiveRecord::Migration
  def up
    rename_table :competitions, :contests
  end

  def down
  end
end
