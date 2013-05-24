class Contract < ActiveRecord::Base
  belongs_to :lead
  belongs_to :contract_type
  belongs_to :contract_state
  belongs_to :matriclicker
  has_many :invoices
  scope :not_invoiced_month, 
	  lambda { |date| { :include => {:invoices => :invoice_months}, 
	  :conditions => [ "(!(invoice_months.month = ? and invoice_months.year = ?) 
	    or (invoice_months.month is null and invoice_months.year is null))", date.month, date.year ] } }
	
  has_many :attached_files, :as => :attachable
	
	accepts_nested_attributes_for :attached_files, :reject_if => proc { |a| a[:attached].blank? }, :allow_destroy => true
	
	validates :lead_id, :presence => true
	validates :contract_state_id, :presence => true
	validates :contract_type_id, :presence => true
	
	def expected_flow_in(month)
    expected_flow = 0    
    if self.should_pay_in(month) and self.no_paid_invoice_for(month)
      expected_flow = self.quota_ammount(month)
    end
    return expected_flow.to_i
  end
  
  def should_pay_in(month)
    from = self.invoice_from.beginning_of_month
    to = self.invoice_to.end_of_month
    months_range_string = (from..to).map{ |date| date.strftime("%Y %b") }.uniq
    
    if self.quotas.blank? or self.quotas == 0
      quotas = 1
    else
      quotas = self.quotas.to_i
    end
    
    distance = (months_range_string.size/quotas).to_i
    
    (0..quotas - 1).each do |i|
      if month.year == (from + (i * distance).months).year and month.month == (from + (i * distance).months).month
        return true
      end
    end
    return false
  end

  def no_paid_invoice_for(month)
    self.invoices.each do |invoice|
      invoice.invoice_months.each do |invoice_month|
        if invoice_month.year == month.to_date.year and invoice_month.month == month.to_date.month and invoice.paid
          return false
        end
      end
    end
    return true
  end
  
  def quota_ammount(month)
    from = self.invoice_from.beginning_of_month
    to = self.invoice_to.end_of_month
    months_range_string = (from..to).map{ |date| date.strftime("%Y %b") }.uniq
    
    if self.quotas.blank? or self.quotas == 0
      quotas = 1
    else
      quotas = self.quotas.to_i
    end
    
    distance = (months_range_string.size/quotas).to_i
    
    if self.price.blank?
      price = 0
    else
      price = self.price
    end
    
    if self.discount.blank?
      discount = 0
    else
      discount = self.discount
    end
    if self.discount_start.blank?
      discount_start = self.invoice_from
    else
      discount_start = self.discount_start
    end
    if self.discount_end.blank?
      discount_end = self.invoice_to
    else
      discount_end = self.discount_end
    end
    if !(discount_end >= month.to_date.beginning_of_month and discount_start <= month.to_date.end_of_month)
      discount = 0
    end
    
    if price < 10000
      quota_ammount = (price * 23700 * distance) * (100 - discount)/100
    else
      quota_ammount = (price * distance) * (100 - discount)/100
    end
    return quota_ammount
  end
  
  
end
