class RenameTable < ActiveRecord::Migration
  def up
    rename_table :gift_cards_dresses, :dresses_gift_cards
  end

  def down
  end
end
