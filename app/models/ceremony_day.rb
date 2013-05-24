class CeremonyDay < ActiveRecord::Base
	belongs_to :ceremony
	has_many :ceremony_day_hours
	accepts_nested_attributes_for :ceremony_day_hours
end
