class MoveSupplierAccountInformationFromSupplierToSupplierAccountTable < ActiveRecord::Migration
  def up
		remove_column :suppliers, :corporate_name
		remove_column :suppliers, :web_page
		remove_column :suppliers, :fantasy_name
		remove_column :suppliers, :rut
		remove_column :suppliers, :phone_number
		remove_column :suppliers, :address
		remove_column :suppliers, :image_file_name
		remove_column :suppliers, :image_content_type
		remove_column :suppliers, :image_file_size
		remove_column :suppliers, :image_updated_at
  end

  def down
		add_column :suppliers, :corporate_name, 		:string
		add_column :suppliers, :web_page, 					:string
		add_column :suppliers, :fantasy_name, 			:string
		add_column :suppliers, :rut, 								:string
		add_column :suppliers, :phone_number, 			:integer
		add_column :suppliers, :address,						:string
		add_column :suppliers, :image_file_name,	 	:string
		add_column :suppliers, :image_content_type,	:string
		add_column :suppliers, :image_file_size, 		:integer
		add_column :suppliers, :image_updated_at,	 	:datetime
  end
end
