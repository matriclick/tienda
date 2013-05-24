class CreateAttachednotes < ActiveRecord::Migration
  def change
    create_table :attachednotes do |t|
      t.string :attachable_type
      t.integer :attachable_id
      t.text :message

      t.timestamps
    end
  end
end
