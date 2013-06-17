class ChangeDataTypeOfShoeSize < ActiveRecord::Migration
  def up
    change_column :shoe_sizes, :size_cl, :float
    change_column :shoe_sizes, :size_us, :float
  end

  def down
  end
end
