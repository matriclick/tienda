class RenameGiftCardStatus < ActiveRecord::Migration
  def up
    rename_column :gift_cards, :status_id, :gift_card_status_id
  end

  def down
  end
end
