class RemoveDateFromBlogComments < ActiveRecord::Migration
  def change
		remove_column :blog_comments, :date
  end
end
