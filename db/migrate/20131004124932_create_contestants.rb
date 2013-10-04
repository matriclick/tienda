class CreateContestants < ActiveRecord::Migration
  def change
    create_table :contestants do |t|
      t.integer :user_id
      t.string :name
      t.text :introduction
      t.string :slug

      t.timestamps
    end
  end
end
