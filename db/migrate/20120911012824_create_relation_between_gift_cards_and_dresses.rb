class CreateRelationBetweenGiftCardsAndDresses < ActiveRecord::Migration
  def up
    create_table :gift_cards_dresses, :id => false do |t|
      t.integer  :gift_card_id
      t.integer  :dress_id
      
      t.timestamps
    end
  end

  def down
  end
end
