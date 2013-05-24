class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.string :reviewable_type
      t.integer :reviewable_id
      t.boolean :supplier_read, :default => false
      t.integer :user_id
      t.boolean :approved_by_admin, :default => false

      t.timestamps
    end
  end
end
