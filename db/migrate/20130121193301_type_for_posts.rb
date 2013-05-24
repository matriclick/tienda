# encoding: UTF-8
class TypeForPosts < ActiveRecord::Migration
  def up
    add_column :posts, :post_type, :string
    Post.all.each do |post|
      post.post_type = 'Post'
      post.save(:validate => false)
    end
  end

  def down
    remove_column :posts, :post_type
  end
end