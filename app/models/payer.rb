class Payer < ActiveRecord::Base
	belongs_to :expense
	belongs_to :payer_type
end
