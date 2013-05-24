class AddUrlPathToCountry < ActiveRecord::Migration

  def self.up
    add_column :countries, :url_path, :string
  end
 
  def self.down
    remove_column :countries, :url_path
  end
  
end
