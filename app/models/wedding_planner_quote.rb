class WeddingPlannerQuote < ActiveRecord::Base
  belongs_to :user
  
	validates :nombre_novia, :email_novio, :email_novia, :nombre_novio, :fono_novia, :fono_novio, :fecha_del_matrimonio, :cantidad_de_invitados, :user_id, :presence => true
	
	def total_budget
	  sum = 0
	  
	  WeddingPlannerQuote.column_names.each do |col|
	    if col.include?('presupuesto')
	      sum = sum + eval('self.'+col).to_i
	    end
    end
    return sum
    
  end
end
