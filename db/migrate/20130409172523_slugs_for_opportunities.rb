class SlugsForOpportunities < ActiveRecord::Migration
  def up
    add_column :opportunities, :slug, :string
    add_index :opportunities, :slug, unique: true
    
    Opportunity.find_each(&:save)
  end

  def down
  end
end
