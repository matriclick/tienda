class AddContactFieldsForDress < ActiveRecord::Migration
  def up
    add_column :dresses, :seller_name, :string
    add_column :dresses, :seller_phone_number, :string
    add_column :dresses, :seller_email, :string
  end

  def down
    remove_column :dresses, :seller_name
    remove_column :dresses, :seller_phone_number
    remove_column :dresses, :seller_email
  end
end
