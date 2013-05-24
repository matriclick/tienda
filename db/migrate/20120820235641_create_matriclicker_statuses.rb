class CreateMatriclickerStatuses < ActiveRecord::Migration
  def change
    create_table :matriclicker_statuses do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
