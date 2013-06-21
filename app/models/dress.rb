# encoding: UTF-8
class Dress < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :introduction, use: :slugged

	has_many :dress_images, :dependent => :destroy
	has_many :dress_requests
	has_many :purchases, :as => :purchasable
	has_many :dress_stock_sizes, :dependent => :destroy
	has_many :sizes, :through => :dress_stock_sizes
  has_one :refund_request
  
  has_and_belongs_to_many :dress_types
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :cloth_measures
  
	belongs_to :dress_status
	belongs_to :supplier_account
	belongs_to :color
	
	has_and_belongs_to_many :gift_cards
	  
	accepts_nested_attributes_for :dress_images, :reject_if => proc { |a| a[:dress].blank? }, :allow_destroy => true
	accepts_nested_attributes_for :dress_stock_sizes, :reject_if => proc { |a| a[:dress].blank? }, :allow_destroy => true
	
	validates :dress_status_id, :presence => true	
	validates :dress_images, :presence => true
	validates :price, :presence => true
	
	def self.get_all_with_tag(start_date, end_date)
    joins(:tags).where('dresses.created_at >= ? and dresses.created_at <= ?', start_date, end_date).uniq
  end
  
	def self.all_filtered(string_filter = nil, separator = ' ')
    if string_filter.nil?
      return Dress.all
    else
      keywords = string_filter.split(separator)
      query = ''
      keywords.each_with_index do |k, i|
        if i == 0
          query = '(description like "%'+k+'%" or introduction like "%'+k+'%")'
        else
          query = '(description like "%'+k+'%" or introduction like "%'+k+'%") and '+query
        end
      end
      return self.where(query).available
    end
  end
	
	def get_related_dresses
	  texto = self.product_keywords
	  if !texto.nil?	    
      if !texto.empty?
    	  keywords = texto.split(",")
    	  like = ''
    	  keywords.each_with_index do |keyword, i|
    	    i > 0 ? like = like+' and ' : ''
    	    like = like+'description like "%'+keyword.strip+'%"'
        end
    	  return self.dress_types.first.dresses.available_to_purchase.where('id <> '+self.id.to_s+' and '+like).order('position').limit(4)
  	  elsif !self.dress_types.first.nil?
  	    return self.dress_types.first.dresses.available_to_purchase.where('id <> '+self.id.to_s).order('position').limit(4)
	    end
    end
    return Array.new
  end
  
  def self.get_related_dresses_by_string(texto = nil)
    unless texto.nil? or texto.empty?
  	  keywords = texto.split(",")
  	  like = ''
  	  keywords.each_with_index do |keyword, i|
  	    i > 0 ? like = like+' and ' : ''
  	    like = like+'description like "%'+keyword.strip+'%"'
      end
  	  return Dress.available_to_purchase.where(like).order('position').limit(4)
    else
  	  return Dress.available_to_purchase.order('position').limit(4)
    end
  end
  
	def dress_type
	  !self.dress_types.first.nil? ? self.dress_types.first : DressType.find_by_name("vestidos-fiesta")
  end
    
	def has_stock?
		self.dress_stock_sizes.each do |dress_stock_size|
	    if !dress_stock_size.stock.blank?
  	    if dress_stock_size.stock > 0
          return true
        end
      end
	  end
	  return false
	end
	
	def has_stock_in_sizes(sizes)
		self.dress_stock_sizes.each do |dress_stock_size|
	    if !dress_stock_size.stock.blank?
  	    if dress_stock_size.stock > 0 and sizes.include?(dress_stock_size.size)
          return true
        end
      end
	  end
	  return false
	end
	
	def independent?
		independent
	end
	
	def self.available
	  oculto_id = DressStatus.find_by_name("Oculto").id
	  vendido_oculto_id = DressStatus.find_by_name("Vendido y Oculto").id
	  
	  where('dress_status_id <> ? and dress_status_id <> ?', oculto_id, vendido_oculto_id).order('position ASC')
  end

	def self.available_to_purchase
	  disp = DressStatus.find_by_name("Disponible").id
	  where('dress_status_id = ?', disp).order('position ASC')
  end
  
  def find_gift_card
    if self.gift_cards.count > 0
      return self.gift_cards.order('value DESC').first
    else
      self.supplier_account.gift_cards.each do |gc|
        if gc.min_price <= self.price and gc.max_price >= self.price
          return gc
        end
      end
    end
    return false
  end
    
  # -------------- PURCHASABLE METHODS -------------------
  
  # def description --> NO ES NECESARIO YA QUE EXISTE EL ATRIBUTO
  # def price --> NO ES NECESARIO YA QUE EXISTE EL ATRIBUTO
  # def refund --> NO ES NECESARIO YA QUE EXISTE EL ATRIBUTO
  # def supplier_account --> NO ES NECESARIO YA QUE EXISTE LA RELACIÓN

  def mark_as_used
  end
  
  def main_image
    self.dress_images.first.dress.url(:index)
  end
  
  def small_image
    self.dress_images.first.dress.url(:side)
  end
  
  def mark_as_sold(size = nil, quantity = nil)
    if self.dress_status_id != DressStatus.find_by_name('Admin-Test').id
      if !size.blank? and !quantity.blank?
        matri_size = Size.find_by_name(size)
    
        dress_stock_size = DressStockSize.where("size_id = ? and dress_id = ?", matri_size.id, self.id).first
        dress_stock_size.stock = dress_stock_size.stock - quantity
        dress_stock_size.save
    
        out_of_stock = true
        self.dress_stock_sizes.each do |dress_stock_size|
          if !dress_stock_size.stock.blank?
            if dress_stock_size.stock > 0
              out_of_stock = false
            end
          end
        end
        if out_of_stock
          self.dress_status_id = DressStatus.find_by_name('Vendido').id
          self.save            
        end
      else
        self.dress_status_id = DressStatus.find_by_name('Vendido').id
        self.save
      end
    end
  end

  # For the methods "link_to_view" and "full_link_to_view", the line "include Rails.application.routes.url_helpers" must be present in the model in order to use the "_path" and "_url" methods.
  def link_to_view(country_url_path, purchase_id = nil)
    purchases_show_for_user_path(:country_url_path => country_url_path, :id => purchase_id)
  end
  
  def full_link_to_view(country_url_path, purchase_id = nil)
    host = 'www.matriclick.com'
    
    purchases_show_for_user_path(:only_path => false, :host => host, :country_url_path => country_url_path, :id => purchase_id)
  end
  # -------------- END PURCHASABLE METHODS -------------------
  
end
