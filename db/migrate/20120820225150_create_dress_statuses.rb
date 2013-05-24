class CreateDressStatuses < ActiveRecord::Migration
  def change
    create_table :dress_statuses do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
