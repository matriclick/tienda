class Lead < ActiveRecord::Base
  include CountryMethods
  after_create :set_country_id_with_locale

  belongs_to :country
  belongs_to :matriclicker
  belongs_to :supplier_account
  belongs_to :industry_category
  has_many :contracts, :dependent => :destroy
  has_many :invoices, :through => :contracts
  has_many :challenges, :dependent => :destroy
  has_many :lead_contacts, :dependent => :destroy
  
  validates :matriclicker_id, :name, :industry_category_id, :presence => true
	
  def unpaid_invoices
    self.invoices.where(:paid => false)
  end
  
  def unpaid_invoices_by_date(from, to)
    self.unpaid_invoices.where('issued_date >= ? and issued_date <= ?', from, to)
  end

  def total_debt
    price = self.invoices.where(:paid => false).sum(:net_price).to_f
    vat = self.invoices.where(:paid => false).sum(:vat).to_f
    return price + vat
  end
  
  def total_debt_by_date(from, to)
    invoices = self.unpaid_invoices_by_date(from, to)
    price = invoices.sum(:net_price).to_f
    vat = invoices.sum(:vat).to_f
    return price + vat
  end
  
  def expected_flow_in(month)
    fijo = ContractType.find_by_name("Fijo")
    mixto = ContractType.find_by_name("Mixto")
    especial = ContractType.find_by_name("Especial")
    
    expected_flow = 0
    self.contracts.where('contracts.contract_type_id = ? or contracts.contract_type_id = ? or contracts.contract_type_id = ?', fijo.id, mixto.id, especial.id).each do |contract|
      expected_flow = expected_flow + contract.expected_flow_in(month)
    end
    return expected_flow
  end
  
  def expected_flow_in_range(months)
    expected_flow = 0
    months.each do |month|
      expected_flow = expected_flow + self.expected_flow_in(month)
    end
    return expected_flow
  end
  
  
  
end
