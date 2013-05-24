class AddColorIdToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :color_id, :integer
  end
end
