class AddEmailsToWeddingPlannerQuote < ActiveRecord::Migration
  def change
    add_column :wedding_planner_quotes, :email_novio, :string
    add_column :wedding_planner_quotes, :email_novia, :string
  end
end
