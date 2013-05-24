class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.integer :matriclicker_id
      t.string :name
      t.integer :country_id
      t.string :webpage
      t.text :description

      t.timestamps
    end
  end
end
