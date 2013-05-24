class AddCeremonyTypeIdToCeremony < ActiveRecord::Migration
  def change
    add_column :ceremonies, :ceremony_type_id, :integer
  end
end
