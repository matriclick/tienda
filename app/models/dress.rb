# encoding: UTF-8
class Dress < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  extend FriendlyId
  
  before_save :set_code
  before_save :check_stock_and_update_status_and_position
  
  friendly_id :introduction, use: :slugged

	has_many :dress_images, :dependent => :destroy
	has_many :dress_requests
	has_many :purchases, :as => :purchasable
	has_many :dress_stock_sizes, :dependent => :destroy
	has_many :sizes, :through => :dress_stock_sizes
  has_many :dresses_users_wish_lists
  has_many :users, :through => :dresses_users_wish_lists

  has_and_belongs_to_many :refund_request
  has_and_belongs_to_many :dress_types
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :cloth_measures
  
	belongs_to :dress_status
	belongs_to :supplier_account
	belongs_to :color
	
	accepts_nested_attributes_for :dress_images, :reject_if => proc { |a| a[:dress].blank? }, :allow_destroy => true
	accepts_nested_attributes_for :dress_stock_sizes, :allow_destroy => true
	
	validates :dress_status_id, :introduction, :description, :presence => true	
	validates :dress_images, :presence => true
	validates :price, :presence => true
	
  def self.to_csv(from, to)
    dresses = Dress.where('created_at >= ? and created_at <= ?', from, to)
    header = ['Id', 'Fecha Creación', 'Fecha Actualización', 'Tipo', 'Introducción', 'Precio', 'Costo Neto', 'IVA', 'Tienda', 'Status', 'Posición', 'Slug', 
              'Precio Original', 'Descuento', 'Código', 'WishList', 'Ventas', 'Carritos Agregado', 'Stock Disponible']
    CSV.generate do |csv|
      csv << header
      dresses.each do |dress|             
        csv << [dress.id, dress.created_at, dress.updated_at, dress.dress_type.name, dress.introduction, dress.price, dress.net_cost, dress.vat_cost, 
                dress.supplier_account.fantasy_name, dress.dress_status.name, dress.position, dress.slug, dress.original_price, dress.discount, dress.code,
                dress.users.size, dress.get_purchases.size, dress.get_shopping_cart_items.size, dress.get_available_stock]
      end
    end
  end
  
  def get_available_stock
    stock = 0
    self.dress_stock_sizes.each do |dsz|
      stock = dsz.stock + stock
    end
    return stock
  end
  
  def get_purchases
    purchases = Array.new
    #Compras directas
    purchases.concat Purchase.where(:purchasable_type => 'Dress', :purchasable_id => self.id, :status => 'finalizado', :funds_received => true)
    #Compras con shopping cart
    scis = self.get_shopping_cart_items
    scis.each do |sci|
      purchases.concat Purchase.where(:purchasable_type => 'ShoppingCart', :purchasable_id => sci.shopping_cart.id, :status => 'finalizado', :funds_received => true)
    end
    return purchases
  end
  
  def get_shopping_cart_items
    return ShoppingCartItem.where(:purchasable_type => 'Dress', :purchasable_id => self.id)
  end
  
  def check_stock_and_update_status_and_position
    if self.dress_status.name != 'Oculto' and self.dress_status.name != 'Vendido y Oculto'
      dszs = self.dress_stock_sizes

      stock_left = false
      
      dszs.each do |dsz|
        if dsz.stock.nil?
          dsz.destroy
        elsif dsz.stock > 0
          stock_left = true
        end
      end
      
      if stock_left
        self.dress_status = DressStatus.find_by_name 'Disponible'
      else
        self.dress_status = DressStatus.find_by_name 'Vendido'        
        if self.position < 90
          self.position = 99
        end
      end
    end
  end
  
  def get_stock_from_size(size_name, color_name)
    size_id = Size.find_by_name(size_name).id if !size_name.nil?
    dress_stock_size = self.dress_stock_sizes.where(:size_id => size_id, :color => color_name).first
    return !dress_stock_size.nil? ? dress_stock_size.stock : 0
  end
  
  def get_available_sizes
    sizes = Array.new
    self.dress_stock_sizes.each do |dsz|
      sizes << dsz.size.name if !dsz.size.nil? and dsz.stock > 0
    end
    return sizes.uniq
  end
  
  def get_available_colors
    colors = Array.new
    self.dress_stock_sizes.each do |dsz|
      colors << dsz.color if !dsz.color.nil? and dsz.color != '' and dsz.stock > 0
    end
    return colors.uniq
  end
  
  def set_code
    if self.code.blank?
      code_s = 'TRA'
      self.dress_type.name.split('-').each do |a|
        code_s = code_s+a[0..1].upcase
      end
      self.code = code_s+self.id.to_s
    end
  end
  
  def self.check_sizes(dresses)
    puts dresses.count
    sizes = Array.new
    dresses.each do |d|
      d.sizes.each do |s|
        unless sizes.include?(s)
          sizes << s
        end
      end
    end
    return sizes
  end
  
	def self.get_all_with_tag(start_date, end_date)
    joins(:tags).where('dresses.created_at >= ? and dresses.created_at <= ?', start_date, end_date).uniq
  end
  
	def self.all_filtered(string_filter = nil, sizes = nil, discount = nil, separator = ' ')
    if string_filter.nil? and sizes.nil? and discount.nil?
      return Dress.all
    end
    
    if !string_filter.nil?
      keywords = Array.new
      keywords = keywords + string_filter.split(separator) if !string_filter.nil?
      
      query = ''
      keywords.each_with_index do |k, i|
        if i == 0
          query = '(dress_types.name like "%'+k+'%" or dresses.description like "%'+k+'%" or dresses.introduction like "%'+k+'%")'
        else
          query = '(dress_types.name like "%'+k+'%" or dresses.description like "%'+k+'%" or dresses.introduction like "%'+k+'%") and '+query
        end
      end
    end
    
    if !sizes.nil?
      query_s = '('
      sizes.each_with_index do |k, i|
        if i == 0
          query_s = 'sizes.name = "'+k+'"'
        else
          query_s = 'sizes.name = "'+k+'" or '+query_s
        end
      end
      query_s+')'
      
      if query.nil?
        query = query_s
      else
        query = query_s +' and '+query
      end
    end
    
    if !discount.nil?
      if query.nil?
        query = 'dresses.discount > '+discount.to_s
      else
        query = '('+query+') and dresses.discount > '+discount.to_s
      end
    end
    
    
    disp = DressStatus.find_by_name("Disponible").id
    vend = DressStatus.find_by_name("Vendido").id
    
    return self.joins(:dress_types).joins(:sizes).where(query).where('dress_status_id = ? or dress_status_id = ?', disp, vend).available
    
  end
	
	def get_related_dresses
	  texto = self.product_keywords
	  if !texto.nil? and self.dress_types.size > 0
      if !texto.empty?
    	  keywords = texto.split(",")
    	  like = ''
    	  keywords.each_with_index do |keyword, i|
    	    i > 0 ? like = like+' and ' : ''
    	    like = like+'description like "%'+keyword.strip+'%"'
        end
    	  return self.dress_types.first.dresses.available_to_purchase.where('id <> '+self.id.to_s+' and '+like).order('position').limit(5)
  	  elsif !self.dress_types.first.nil?
  	    return self.dress_types.first.dresses.available_to_purchase.where('id <> '+self.id.to_s).order('position').limit(5)
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
	  
	  where('dress_status_id <> ? and dress_status_id <> ?', oculto_id, vendido_oculto_id)
  end
      
	def self.available_to_purchase
	  disp = DressStatus.find_by_name("Disponible").id
	  where('dress_status_id = ?', disp).order('position ASC')
  end
    
  # -------------- PURCHASABLE METHODS -------------------
  
  # def description --> NO ES NECESARIO YA QUE EXISTE EL ATRIBUTO
  # def price --> NO ES NECESARIO YA QUE EXISTE EL ATRIBUTO
  # def refund --> NO ES NECESARIO YA QUE EXISTE EL ATRIBUTO
  # def supplier_account --> NO ES NECESARIO YA QUE EXISTE LA RELACIÓN

  def mark_as_used
  end
  
  def main_image
    self.dress_images.first.dress.url(:main)
  end
  
  def small_image
    self.dress_images.first.dress.url(:side)
  end
  
  def mark_as_sold(size = nil, quantity = nil)
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

  # For the methods "link_to_view" and "full_link_to_view", the line "include Rails.application.routes.url_helpers" must be present in the model in order to use the "_path" and "_url" methods.
  def link_to_view(purchase_id = nil)
    purchases_show_for_user_path(:id => purchase_id)
  end
  
  def full_link_to_view(purchase_id = nil)
    host = 'www.tramanta.com'
    
    purchases_show_for_user_path(:only_path => false, :host => host, :id => purchase_id)
  end
  # -------------- END PURCHASABLE METHODS -------------------
  
end
