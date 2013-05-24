class RemoveTypeIDfromDresses < ActiveRecord::Migration
  def up
    remove_column :dresses, :dress_type_id
  end

  def down
  end
end
