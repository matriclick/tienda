class AddValidToToGiftCard < ActiveRecord::Migration
  def change
    add_column :gift_cards, :valid_to, :date
  end
end
