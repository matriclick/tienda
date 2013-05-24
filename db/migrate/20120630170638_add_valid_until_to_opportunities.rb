class AddValidUntilToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :valid_until, :date
  end
end
