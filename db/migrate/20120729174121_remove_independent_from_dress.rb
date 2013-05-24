class RemoveIndependentFromDress < ActiveRecord::Migration
  def up
    remove_column :dresses, :independent
  end

  def down
    add_column :dresses, :independent, :boolean
  end
end
