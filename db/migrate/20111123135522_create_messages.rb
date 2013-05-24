class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :conversation_id
    	t.string :transmitter
      t.text :content
      t.boolean :read

      t.timestamps
    end
  end
end
