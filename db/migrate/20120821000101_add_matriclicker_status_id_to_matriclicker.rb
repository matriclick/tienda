class AddMatriclickerStatusIdToMatriclicker < ActiveRecord::Migration
  def change
    add_column :matriclickers, :matriclicker_status_id, :integer
  end
end
