class CreateCeremonyTypes < ActiveRecord::Migration
  def change
    create_table :ceremony_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
