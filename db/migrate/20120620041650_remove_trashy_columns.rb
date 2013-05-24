class RemoveTrashyColumns < ActiveRecord::Migration
  def up
    remove_column :post_images, :post_id
  end

  def down
  end
end
