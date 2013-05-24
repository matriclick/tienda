class AddUserIdToStarRatings < ActiveRecord::Migration
  def change
    add_column :star_ratings, :user_id, :integer
  end
end
