class AddFieldsToService < ActiveRecord::Migration
  def change
    add_column :services, :price, :integer
    add_column :services, :price_description, :string
    add_column :services, :top_price_range, :integer
  end
end
