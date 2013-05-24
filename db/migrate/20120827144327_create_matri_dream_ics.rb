class CreateMatriDreamIcs < ActiveRecord::Migration
  def change
    create_table :matri_dream_ics do |t|
      t.integer :industry_category_id

      t.timestamps
    end
  end
end
