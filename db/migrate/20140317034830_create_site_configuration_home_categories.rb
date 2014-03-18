class CreateSiteConfigurationHomeCategories < ActiveRecord::Migration
  def change
    create_table :site_configuration_home_categories do |t|
      t.integer :site_configuration_id
      t.integer :home_category_id
      t.integer :position

      t.timestamps
    end
  end
end
