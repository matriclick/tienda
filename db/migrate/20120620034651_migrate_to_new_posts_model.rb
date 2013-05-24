class MigrateToNewPostsModel < ActiveRecord::Migration
  def up
      
    posts = Post.all
    
    posts.each do |p|
      
      pc = PostContent.new content: p.content
      pc.post_id = p.id
      pc.save
      
      p.update_attribute :content, "Proximamente en Matriclick.com"
      
    end
  end

  def down
    
  end
end
