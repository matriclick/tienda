class PayerType < ActiveRecord::Base
	has_many :payers, :dependent => :destroy
end
