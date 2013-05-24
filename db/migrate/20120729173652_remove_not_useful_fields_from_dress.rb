class RemoveNotUsefulFieldsFromDress < ActiveRecord::Migration
  def up
    remove_column :dresses, :seller_name
    remove_column :dresses, :seller_phone_number
    remove_column :dresses, :seller_email
    remove_column :dresses, :sold
  end

  def down
    add_column :dresses, :seller_name, :string
    add_column :dresses, :seller_phone_number, :string
    add_column :dresses, :seller_email, :string
    add_column :dresses, :sold, :boolean
  end
end
