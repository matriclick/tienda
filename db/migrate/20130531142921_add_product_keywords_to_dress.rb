class AddProductKeywordsToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :product_keywords, :string
  end
end
