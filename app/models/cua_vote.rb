class CuaVote < ActiveRecord::Base
	belongs_to :campaign_user_account_info
	belongs_to :user
end
