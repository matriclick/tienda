class CreateInvitationsTable < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_account_id
      t.string :text
			t.string :background_image

      t.timestamps
    end
  end
end
