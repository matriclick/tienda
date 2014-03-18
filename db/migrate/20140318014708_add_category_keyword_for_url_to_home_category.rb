class AddCategoryKeywordForUrlToHomeCategory < ActiveRecord::Migration
  def change
    add_column :home_categories, :category_keyword_for_url, :string
  end
end
