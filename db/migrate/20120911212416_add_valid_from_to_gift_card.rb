class AddValidFromToGiftCard < ActiveRecord::Migration
  def change
    add_column :gift_cards, :valid_from, :date
  end
end
