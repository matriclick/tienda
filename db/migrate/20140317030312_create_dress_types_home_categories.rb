class CreateDressTypesHomeCategories < ActiveRecord::Migration
  def up
    create_table :dress_types_home_categories, :id => false do |t|
      t.integer :dress_type_id
      t.integer :home_category_id
    end
  end

  def down
  end
end
