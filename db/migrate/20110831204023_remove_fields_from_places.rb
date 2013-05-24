class RemoveFieldsFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :max_capacity
    remove_column :places, :rent_cost
    remove_column :places, :rent_type_id
  end

  def down
    add_column :places, :rent_type_id, :integer
    add_column :places, :rent_cost, :integer
    add_column :places, :max_capacity, :integer
  end
end
