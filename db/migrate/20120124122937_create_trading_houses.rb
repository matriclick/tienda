class CreateTradingHouses < ActiveRecord::Migration
  def change
    create_table :trading_houses do |t|
      t.string :name

      t.timestamps
    end
  end
end
