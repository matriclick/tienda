class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :question
      t.string :answer
      t.integer :ceremony_type_id

      t.timestamps
    end
  end
end
