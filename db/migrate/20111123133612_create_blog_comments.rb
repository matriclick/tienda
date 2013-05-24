class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.string :name
      t.date :date
      t.text :comment
      t.integer :post_id

      t.timestamps
    end
  end
end
