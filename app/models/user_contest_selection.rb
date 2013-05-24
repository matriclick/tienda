class UserContestSelection < ActiveRecord::Base
  belongs_to :user
  belongs_to :matri_dream_ic
  belongs_to :supplier_account
    	
end
