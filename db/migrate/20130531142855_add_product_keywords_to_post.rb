class AddProductKeywordsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :product_keywords, :string
  end
end
