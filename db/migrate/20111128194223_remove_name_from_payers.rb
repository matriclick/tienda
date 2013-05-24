class RemoveNameFromPayers < ActiveRecord::Migration
  def up
    remove_column :payers, :name
  end

  def down
    add_column :payers, :name, :string
  end
end
