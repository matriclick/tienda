class Presentation < ActiveRecord::Base
	belongs_to :supplier_account
	has_many :presentation_images, :dependent => :destroy
	accepts_nested_attributes_for :presentation_images, :reject_if => proc { |a| a[:image].blank? }, :allow_destroy => true
end
