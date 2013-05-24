class AddPostContentIdToPostImage < ActiveRecord::Migration
  def change
    add_column :post_images, :post_content_id, :integer
  end
end
