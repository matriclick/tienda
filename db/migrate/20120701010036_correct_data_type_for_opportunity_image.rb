class CorrectDataTypeForOpportunityImage < ActiveRecord::Migration
  def up
    change_table :opportunity_images do |t|
      t.change :opportunity_image_updated_at, :string
    end
  end

  def down
  end
end
