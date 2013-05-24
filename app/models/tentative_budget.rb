class TentativeBudget < ActiveRecord::Base
	belongs_to :budget_range
	
  validates :budget_range, :presence => true
end
