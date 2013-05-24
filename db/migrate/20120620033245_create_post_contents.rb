class CreatePostContents < ActiveRecord::Migration
  def change
    unless PostContent.table_exists?
      create_table :post_contents do |t|
        t.integer :post_id
        t.text :content
        t.timestamps
      end
    end
  end
end
