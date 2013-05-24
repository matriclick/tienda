class ImportantDate < ActiveRecord::Base
  belongs_to :supplier_account
  
  # Validations
  validates :date, :date_name, :ends_date, :supplier_account_id, :presence => true
  validate :date_range
  
  def date_range
  	unless ends_date.blank? or date.blank?
			if ends_date < date
				errors.add(:ends_date, "Debe ser mayor a fecha inicio")
			end
		end
  end
end
