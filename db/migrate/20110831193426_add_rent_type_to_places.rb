class AddRentTypeToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :rent_type_id, :integer
  end
end
