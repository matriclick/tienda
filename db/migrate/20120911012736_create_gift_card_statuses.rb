class CreateGiftCardStatuses < ActiveRecord::Migration
  def change
    create_table :gift_card_statuses do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
