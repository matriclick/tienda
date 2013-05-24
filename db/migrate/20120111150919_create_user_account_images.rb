class CreateUserAccountImages < ActiveRecord::Migration
  def change
    create_table :user_account_images do |t|
      t.integer :user_account_id
      t.string :couple_file_name
      t.string :couple_content_type
      t.integer :couple_file_size
      t.datetime :couple_updated_at

      t.timestamps
    end
  end
end
