class AddColorToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :color_type_id, :integer
  end
end
