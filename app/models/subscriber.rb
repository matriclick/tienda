# encoding: UTF-8
class Subscriber < ActiveRecord::Base
  has_and_belongs_to_many :subscriber_preferences
	belongs_to :commune
	
  validates :email, :email => true, :presence => true
  
	
  def self.to_csv(from, to)
  	header = ['Correo', 'Fecha Inscripción', 'Comuna']
    subscribers = Subscriber.where('created_at >= ? and created_at <= ?', from, to).order 'created_at DESC'
  
    CSV.generate do |csv|
      csv << header
      subscribers.each do |subscriber|
        csv << [subscriber.email, subscriber.created_at, subscriber.commune.nil? ? '' : subscriber.commune.name]
      end
    end
  end
  
end
