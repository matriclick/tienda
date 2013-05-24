class UserAccountTradingHouse < ActiveRecord::Base
	belongs_to :user_account
	belongs_to :trading_house
end
