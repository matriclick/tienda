class AddContestImage < ActiveRecord::Migration
  def up
    add_attachment :contests, :image
  end

  def down
  end
end
