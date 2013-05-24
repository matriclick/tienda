class CreateWebpageContactStates < ActiveRecord::Migration
  def change
    create_table :webpage_contact_states do |t|
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
