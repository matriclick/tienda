class CreatePayers < ActiveRecord::Migration
  def change
    create_table :payers do |t|
      t.integer :expense_id
      t.string :name
      t.decimal :percentage

      t.timestamps
    end
  end
end
