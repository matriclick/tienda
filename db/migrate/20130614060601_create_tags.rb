class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.text :description
      t.string :image_name
      t.integer :tag_type_id

      t.timestamps
    end
  end
end
