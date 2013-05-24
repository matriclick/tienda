class AddHiddenToIndustryCategory < ActiveRecord::Migration
  def change
    add_column :industry_categories, :hidden, :boolean, :default => 0
  end
end
