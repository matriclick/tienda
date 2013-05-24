class CeremonyType < ActiveRecord::Base
	has_many :ceremonies
	has_many :tips
end
