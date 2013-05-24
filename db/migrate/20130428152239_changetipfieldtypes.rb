class Changetipfieldtypes < ActiveRecord::Migration
  def up
    change_column :tips, :question, :text
    change_column :tips, :answer, :text
  end

  def down
  end
end
