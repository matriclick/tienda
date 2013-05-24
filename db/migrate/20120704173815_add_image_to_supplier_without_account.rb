class AddImageToSupplierWithoutAccount < ActiveRecord::Migration
  def self.up           
    add_column :supplier_without_accounts, :image_file_name, :string
    add_column :supplier_without_accounts, :image_content_type, :string
    add_column :supplier_without_accounts, :image_file_size, :integer
    add_column :supplier_without_accounts, :image_updated_at, :datetime
  end                   

  def self.down            
    remove_column :supplier_without_accounts, :image_file_name
    remove_column :supplier_without_accounts, :image_content_type
    remove_column :supplier_without_accounts, :image_file_size
    remove_column :supplier_without_accounts, :image_updated_at
  end                      
end

