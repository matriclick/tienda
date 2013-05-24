class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|

      t.string :name
      t.string :lastname_p
      t.string :lastname_m
      t.string :phone_number
      t.string :email

      t.boolean :confirmed ,:default=>false

      t.integer :gender_id
      t.integer :age_id
      t.integer :inviteestatus_id
      t.integer :address_id






      t.timestamps
    end
  end
end

