class CreateGiftCardCodes < ActiveRecord::Migration
  def change
    create_table :gift_card_codes do |t|
      t.string :code
      t.boolean :bought
      t.boolean :used
      t.integer :gift_card_id

      t.timestamps
    end
  end
end
