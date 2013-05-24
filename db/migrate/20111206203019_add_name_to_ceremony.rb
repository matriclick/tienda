class AddNameToCeremony < ActiveRecord::Migration
  def change
    add_column :ceremonies, :name, :string
  end
end
