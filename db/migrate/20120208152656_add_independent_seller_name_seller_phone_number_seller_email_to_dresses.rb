class AddIndependentSellerNameSellerPhoneNumberSellerEmailToDresses < ActiveRecord::Migration
  def change
    add_column :dresses, :independent, :boolean, :default => false
    add_column :dresses, :seller_name, :string
    add_column :dresses, :seller_phone_number, :string
    add_column :dresses, :seller_email, :string
  end
end
