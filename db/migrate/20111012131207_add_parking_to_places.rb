class AddParkingToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :parking, :string
  end
end
