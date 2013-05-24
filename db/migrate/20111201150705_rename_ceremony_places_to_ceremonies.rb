class RenameCeremonyPlacesToCeremonies < ActiveRecord::Migration
  def change
    rename_table :ceremony_places, :ceremonies
  end
end
