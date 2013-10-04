class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.text :instructions
      t.string :slug

      t.timestamps
    end
  end
end
