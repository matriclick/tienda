class SavePostsAgain < ActiveRecord::Migration
  def up
    Post.find_each(&:save)
  end

  def down
  end
end
