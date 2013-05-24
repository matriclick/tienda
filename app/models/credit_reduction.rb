class CreditReduction < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :credit
	
end
