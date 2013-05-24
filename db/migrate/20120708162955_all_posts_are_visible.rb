class AllPostsAreVisible < ActiveRecord::Migration
  def up
    posts = Post.all
    
    posts.each do |p|
      p.update_attribute :visible, true
    end
    
  end

  def down
  end
end
