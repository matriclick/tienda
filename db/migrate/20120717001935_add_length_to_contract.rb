class AddLengthToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :length, :integer
  end
end
