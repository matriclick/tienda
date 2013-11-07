class SupplierAccount < ActiveRecord::Base
  include CountryMethods

  extend FriendlyId
  friendly_id :fantasy_name, :use => :slugged, :slug_column => :public_url
  
  after_create :set_country_id_with_locale
  after_create :add_address_if_nil
  before_validation :correct_rut_format
	before_validation :correct_phone_number_format
  	
  has_one :presentation, :dependent => :destroy
  belongs_to :country
	belongs_to :supplier
  belongs_to :supplier_account_type
	belongs_to :address, :dependent => :destroy

	has_many :user_accounts, :through => :conversations
  has_many :dresses, :dependent => :destroy
	has_many :supplier_contacts, :dependent => :destroy
  has_many :store_payments, :dependent => :destroy
  
  has_and_belongs_to_many :users

	has_attached_file :image, 
											:styles => {
												:tiny => "40x40>",
												:thumb => "100x100>",
												:small => "200x200>",
                        :medium => "300x300>",
                        :large => "400x400>"
	}, :whiny => false, :dependent => :destroy
  
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
  validates_attachment_size :image, :less_than => 1.megabyte

  validates :corporate_name, :public_url, :uniqueness => true
  validates :corporate_name, :fantasy_name, :phone_number, :public_url, :presence => true
  validates :booking_resources, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :rut, :rut => true, :allow_blank => true
  # FGM: Needs a fix on client_side_validations
  # validates :rut, :uniqueness => true, :allow_blank => true
  validates :phone_number, :phone_number => true

	accepts_nested_attributes_for :supplier_contacts, :allow_destroy => true, :reject_if => lambda { |a| (a[:name].blank? or a[:email].blank?) }
  accepts_nested_attributes_for :address

	#http://railscasts.com/episodes/108-named-scope
	scope :from_industry, lambda { |ic| { :joins => :industry_categories, :conditions => [ "industry_categories.id = ?", ic.id ] } }
  
  def check_owned_products_purchased_from_purchases(purchases)
    purchased_products_data = Array.new
    
    purchases.each do |p|
      if p.purchasable_type == 'Dress'
        if p.purchasable.supplier_account == self
          purchased_products_data <<
            Hash[:dress_id => p.purchasable_id, :date => p.created_at, :size => p.size, :quantity => p.quantity, :store_paid => p.store_paid, :color => '', :refunded => p.refunded, :unit_cost => (p.total_cost.nil? ? 0 : p.total_cost/p.quantity), :price => p.purchasable_price]
        end
      else
        p.purchasable.shopping_cart_items.each do |sci|
          if sci.purchasable.supplier_account_id == self.id
            purchased_products_data <<
              Hash[:sci_id => sci.id, :dress_id => sci.purchasable_id, :date => p.created_at, :size => sci.size, :quantity => sci.quantity, :color => sci.color, :store_paid => sci.store_paid, :refunded => sci.refunded, :unit_cost => sci.unit_cost, :price => sci.price]
          end
        end
      end
    end
    return purchased_products_data
  end
  
  def check_view(view)
    unless view.nil? or view == "Ver todos"
      if view == "Ver solo con stock"
        where('dress_status_id == ? or dress_status_id == ?', DressStatus.find_by_name('Disponible').first.id, DressStatus.find_by_name('Oculto').first.id)
      elsif view == "Ver solo agotados"
        where('dress_status_id == ? or dress_status_id == ?', DressStatus.find_by_name('Vendido y Oculto').first.id, DressStatus.find_by_name('Vendido').first.id)
      end
    end
  end
  
  def get_sold_items(from, to)
    quantity = 0
    amount = 0
    refund_quantity = 0
    refund_amount = 0

		Purchase.where('status = ? and purchasable_type = ? and created_at >= ? and created_at <= ?', "finalizado", "ShoppingCart", from.utc, to.utc).each do |p|
			p.purchasable.shopping_cart_items.each do |sci|
				if sci.get_store.id == self.id
          quantity = quantity + 1
					amount = amount + sci.price
          refund_quantity = refund_quantity + 1 if sci.refunded
          refund_amount = refund_amount + sci.price if sci.refunded
				end
			end
		end
    return {:quantity => quantity, :amount => amount, :refund_quantity => refund_quantity, :refund_amount => refund_amount}
  end
  
  def get_purchases_not_paid(from, to)
    purchases = Array.new
    self.dresses.each do |dress|
      p_simple = Purchase.where('store_paid = ? and purchasable_id = ? and status = ? and created_at >= ? and created_at <= ?', false, dress.id, 'finalizado', from, to)      
      p_shopping_cart = Purchase.joins('LEFT JOIN shopping_carts ON purchases.purchasable_id = shopping_carts.id').joins('LEFT JOIN shopping_cart_items ON shopping_carts.id = shopping_cart_items.shopping_cart_id').where('store_paid = ? and shopping_cart_items.purchasable_id = ? and status = ? and purchases.created_at >= ? and purchases.created_at <= ?', false, dress.id, 'finalizado', from, to)
      purchases.concat(p_simple) if p_simple.size > 0
      purchases.concat(p_shopping_cart) if p_shopping_cart.size > 0  
    end
    return purchases.uniq
  end
  
  def get_money_owed(purchases)
    debt = 0
    purchases.each do |p|
      if p.purchasable_type == 'Dress'
        debt = debt + p.total_cost if (p.purchasable.supplier_account_id == self.id and !p.store_paid and !p.total_cost.nil?)
      else
        p.purchasable.shopping_cart_items.each do |sci|
          debt = debt + sci.total_cost if (sci.purchasable.supplier_account_id == self.id and !p.store_paid and !p.total_cost.nil?)
        end
      end
    end
    return debt
  end
  
  def get_supplier_products_not_paid(purchases)
    products = Array.new
    purchases.each do |p|
      if p.purchasable_type == 'Dress'
        products << p.purchasable if (p.purchasable.supplier_account_id == self.id and !p.store_paid)
      else
        p.purchasable.shopping_cart_items.each do |sci|
          products << sci.purchasable if (sci.purchasable.supplier_account_id == self.id and !p.store_paid)
        end
      end
    end
    return products
  end
  
  def dresses_filtered(string_filter = nil, separator = ' ')
    if string_filter.nil?
      return self.dresses
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
      return self.dresses.where(query)
    end
  end
  
  def image_name
    file_name = self.image_file_name
	  return !file_name.nil? ? file_name[0..file_name.index('.')-1].gsub('-', ' ') : 'sin-imagen'
	end
 
	# FGM: Self information
	def self.approved
		where(:approved_by_us => true, :approved_by_supplier => true)
	end
		
	def self.alphabetized
		order(:corporate_name => :asc)
	end
	
	def is_approved?
		self.approved_by_us and self.approved_by_supplier
	end
		
	private
	# Correct format for Rut (a string without "." or "-")
	def correct_rut_format
	  self.rut.gsub!(/[-]|[.]/, "") unless self.rut.blank?
 	end

	def correct_phone_number_format
		self.phone_number.gsub!(/[^\d^+]/, "") unless self.phone_number.blank?
 	end

  def add_address_if_nil
    if self.address.nil?
        a = Address.new
        a.save
        self.address = a
        self.save(:validate => false)
      end
  end
	
end
