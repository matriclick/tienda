class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.integer :matriclicker_id
      t.integer :lead_id
      t.string :name
      t.date :follow_up_date
      t.text :description

      t.timestamps
    end
  end
end
