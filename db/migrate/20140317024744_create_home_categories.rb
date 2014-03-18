class CreateHomeCategories < ActiveRecord::Migration
  def change
    create_table :home_categories do |t|
      t.string :title
      t.string :see_more_text
      t.text :description

      t.timestamps
    end
  end
end
