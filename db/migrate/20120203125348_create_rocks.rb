class CreateRocks < ActiveRecord::Migration
  def change
    create_table :rocks do |t|
			t.belongs_to :gender
      t.string :sender_email
      t.string :recipient_email
      t.string :sender_name
      t.string :recipient_name

      t.timestamps
    end
  end
end
