class CreateDressImages < ActiveRecord::Migration
  def change
    create_table :dress_images do |t|
      t.string :dress_file_name
      t.string :dress_content_type
      t.integer :dress_file_size
      t.datetime :dress_updated_at
			t.integer :dress_id

      t.timestamps
    end
  end
end
