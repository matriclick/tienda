class Region < ActiveRecord::Base
	has_many :communes
	has_many :addresses
	
  def dispatch_cost
    self.communes.first.dispatch_cost
  end

  def dispatch_cost=(cost)
    self.communes.each do |commune|
      commune.dispatch_cost = cost
      commune.save
    end
  end  
end
