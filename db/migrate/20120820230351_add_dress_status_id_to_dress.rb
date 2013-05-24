class AddDressStatusIdToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :dress_status_id, :integer
  end
end
