class CreateAttachedFiles < ActiveRecord::Migration
  def change
    create_table :attached_files do |t|
      t.string :attachable_type
      t.integer :attachable_id
      t.string :attached_file_name
      t.string :attached_content_type
      t.integer :attached_file_size
      t.datetime :attached_updated_at

      t.timestamps
    end
  end
end
