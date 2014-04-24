# encoding: UTF-8
class Credit < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :user
  has_many :credit_reductions
  
  def self.to_csv(from, to)
  	header = ['Usuario', 'Fecha Creación', 'Razón', 'Créditos Obtenidos', 'Créditos Disponibles', 'Fecha Expiración']
    credits = Credit.where('created_at >= ? and created_at <= ?', from, to).order 'created_at DESC'
  
    CSV.generate do |csv|
      csv << header
      credits.each do |credit|
        csv << [credit.user.email, credit.created_at, credit.formula, credit.value, credit.available_credit, credit.expiration_date]
      end
    end
  end  
  
  def self.is_active
    today = DateTime.now.utc.beginning_of_day
    where('active = true and expiration_date < ?', today)
  end
  
  def available_credit
    if self.credit_reductions.count > 0
      reduction = 0
      self.credit_reductions.each do |red|
        reduction = reduction + red.value
      end
      return self.value - reduction
    else
      return self.value
    end
  end
  
end
