class Size < ActiveRecord::Base
	has_many :dress_stock_sizes, :dependent => :destroy
	has_many :dresses, :through => :dress_stock_sizes
	has_and_belongs_to_many :dress_types
  validates_uniqueness_of :name
	
  def count_matching(dresses)
    count = 0
    dresses.each do |dress|
      count = count + 1 if dress.sizes.include? self
    end
    return count
  end
end
