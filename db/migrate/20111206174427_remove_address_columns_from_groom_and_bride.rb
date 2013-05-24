class RemoveAddressColumnsFromGroomAndBride < ActiveRecord::Migration
  def up
		remove_column :grooms, :city
		remove_column :grooms, :commune
		remove_column :grooms, :country
		remove_column :brides, :city
		remove_column :brides, :commune
		remove_column :brides, :country
	end

  def down
		add_column :grooms, :city, :string
		add_column :grooms, :commune, :string
		add_column :grooms, :country, :string
		add_column :brides, :city, :string
		add_column :brides, :commune, :string
		add_column :brides, :country, :string
  end
end
