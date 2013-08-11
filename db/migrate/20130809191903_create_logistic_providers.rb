class CreateLogisticProviders < ActiveRecord::Migration
  def change
    create_table :logistic_providers do |t|
      t.string :name

      t.timestamps
    end
  end
end
