class CreateTableMatriclickPrivileges < ActiveRecord::Migration
  def up
    create_table :matriclickers_privileges, :id => false do |t|
      t.integer :matriclicker_id
      t.integer :privilege_id
          
      t.timestamps
    end
  end

  def down
  end
end
