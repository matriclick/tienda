class CreateMatriclickers < ActiveRecord::Migration
  def change
    create_table :matriclickers do |t|
      t.string :name
      t.integer :user_id
      t.string :roled
      t.text :description

      t.timestamps
    end
  end
end
