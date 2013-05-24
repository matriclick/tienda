class CreateDeliveryInfos < ActiveRecord::Migration
  def change
    drop_table :delivery_infos if table_exists?(:delivery_infos)
    
    create_table :delivery_infos do |t|
      t.string :name
      t.string :rut
      t.string :contact_phone
      t.string :street
      t.string :number
      t.integer :commune_id
      t.text :additional_info

      t.timestamps
    end
  end
end
