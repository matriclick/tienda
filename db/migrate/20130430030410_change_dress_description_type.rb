class ChangeDressDescriptionType < ActiveRecord::Migration
  def up
    change_column :dresses, :description, :text
  end

  def down
  end
end
