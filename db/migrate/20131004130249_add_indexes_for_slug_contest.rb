class AddIndexesForSlugContest < ActiveRecord::Migration
  def up
    add_index :contestants, :slug, unique: true
    add_index :competitions, :slug, unique: true
  end

  def down
  end
end
