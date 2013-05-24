# encoding: UTF-8
class CreatePackPromotions < ActiveRecord::Migration
  def change
    create_table :pack_promotions do |t|
      t.string :name
      t.string :description
      t.string :link
      
      t.string :pack_promotion_image_file_name
      t.string :pack_promotion_image_content_type
      t.integer :pack_promotion_image_file_size
      t.datetime :pack_promotion_image_updated_at

      t.timestamps
    end
    
    create_table :pack_promotions_posts, :id => false do |t|
      t.integer :pack_promotion_id
      t.integer :post_id
    end
    
  end
end
