class AddCellPhoneToLeadContact < ActiveRecord::Migration
  def self.up
    add_column :lead_contacts, :cell_phone, :string
  end
 
  def self.down
    remove_column :lead_contacts, :cell_phone
  end
end
