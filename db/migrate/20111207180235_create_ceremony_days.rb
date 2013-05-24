class CreateCeremonyDays < ActiveRecord::Migration
  def change
    create_table :ceremony_days do |t|
      t.integer :ceremony_id
      t.string :name

      t.timestamps
    end
  end
end
