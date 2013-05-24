class CreateUserAccountTradingHouses < ActiveRecord::Migration
  def change
    create_table :user_account_trading_houses do |t|
      t.integer :user_account_id
      t.integer :trading_house_id
      t.string :trading_house_code

      t.timestamps
    end
  end
end
