class Commune < ActiveRecord::Base
	belongs_to :region
	has_many :addresses
	has_many :delivery_infos
end
