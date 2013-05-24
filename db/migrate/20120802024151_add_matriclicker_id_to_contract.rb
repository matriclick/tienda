class AddMatriclickerIdToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :matriclicker_id, :integer
  end
end
