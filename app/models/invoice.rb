class Invoice < ActiveRecord::Base
  belongs_to :contract
  has_and_belongs_to_many :invoice_months
  has_many :attached_files, :as => :attachable
	has_one :lead, :through => :contract
	
	accepts_nested_attributes_for :attached_files, :reject_if => proc { |a| a[:attached].blank? }, :allow_destroy => true
	
end
