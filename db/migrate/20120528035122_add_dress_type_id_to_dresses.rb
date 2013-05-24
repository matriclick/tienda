class AddDressTypeIdToDresses < ActiveRecord::Migration
  def change
    add_column :dresses, :dress_type_id, :integer
  end
end
