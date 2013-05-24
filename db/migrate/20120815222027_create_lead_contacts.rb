class CreateLeadContacts < ActiveRecord::Migration
  def change
    create_table :lead_contacts do |t|
      t.integer :lead_id
      t.string :position
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
