class CreateStarRatings < ActiveRecord::Migration
  def change
    create_table :star_ratings do |t|
      t.integer :value
      t.string :rateable_type
      t.integer :rateable_id

      t.timestamps
    end
  end
end
