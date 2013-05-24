class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.text :description

      t.timestamps
    end
  end
end
