class AddFieldsToSupplier < ActiveRecord::Migration
  def change
		add_column :suppliers, :corporate_name, :string
		add_column :suppliers, :web_page, :string
		add_column :suppliers, :fantasy_name, :string
		add_column :suppliers, :rut, :string
  end
end
