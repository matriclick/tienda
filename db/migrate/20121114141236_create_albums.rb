class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :supplier_account_id
      t.integer :industry_category_id
      t.boolean :visible

      t.timestamps
    end
  end
end
