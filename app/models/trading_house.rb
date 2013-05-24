class TradingHouse < ActiveRecord::Base
	has_many :user_account_trading_house
	has_many :user_accounts, :through => :user_account_trading_house
end
