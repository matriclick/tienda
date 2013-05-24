class ChangeColumnNameFromMatriclickers < ActiveRecord::Migration
  def up
    rename_column :matriclickers, :roled, :role
  end

  def down
  end
end
