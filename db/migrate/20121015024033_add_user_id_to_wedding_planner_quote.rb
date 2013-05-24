class AddUserIdToWeddingPlannerQuote < ActiveRecord::Migration
  def change
    add_column :wedding_planner_quotes, :user_id, :integer
  end
end
