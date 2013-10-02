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
            Hash[:dress_id => p.purchasable_id, :date => p.created_at, :size => p.size, :quantity => p.quantity, :store_paid => p.store_paid, :refunded => p.refunded, :unit_cost => sci.total_cost/quantity, :price => p.purchasable_price]
        end
      else
        p.purchasable.shopping_cart_items.each do |sci|
          if sci.purchasable.supplier_account_id == self.id
            purchased_products_data <<
              Hash[:sci_id => sci.id, :dress_id => sci.purchasable_id, :date => p.created_at, :size => sci.size, :quantity => sci.quantity, :store_paid => sci.store_paid, :refunded => sci.refunded, :unit_cost => sci.unit_cost, :price => sci.price]
          end
        end
      end
    end
    return purchased_products_data
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
  
	def has_discount
	  if self.services.where("discount > 0").count > 0 or self.products.where("discount > 0").count > 0
	    return true
    end
    return false
  end
  	
  def main_industry_category
    self.industry_categories.first
  end
	# FGM: Bookable = Product/Service that have one or more bookings
	def bookables(options = {})
		options[:date].present? ? @bookings = bookings.where(:date => options[:date]) : @bookings = bookings
		@bookings = @bookings.by_status(:except => options[:except]) if options[:except].present?
		@bookings.collect { |b| b.bookable }.uniq.reject {|a| a.nil?}
	end
	
	# FGM: Check if date should be blocked based on available booking_resources
	def should_create_no_more_booking?(date)
		confirmed_booking_resources(date) >= self.booking_resources
	end
	
	def confirmed_booking_resources(date)
		self.bookables(:date => date, :except => :custom).map{ |b| b.bookings.where(date: date).by_status(status: :confirmed).count * b.booking_resources_consumed }.sum
	end
	
	# FGM: Self information
	def self.approved
		where(:approved_by_us => true, :approved_by_supplier => true)
	end
		
	def self.alphabetized
		order(:corporate_name => :asc)
	end
	
	def self.suggested
		where(:suggested_for_campaign => true)
	end
	
	# FGM: Not used
	def self.random
		order( 'rand()')
	end
		
	def self.by_industry_category(id, name = nil)
		if id
			joins(:industry_categories).where("industry_categories.id = #{id}")
		elsif name
			joins(:industry_categories).where("industry_categories.name = #{name}")
		else
			scoped
		end
	end
	
	def unread_bookings?
		events.supplier_unread.blank? ? false : true
	end

	def is_approved?
		self.approved_by_us and self.approved_by_supplier
	end
	
 	def validate_industry_category
    hasitems = false
    for p in self.products
      if self.industry_categories.find_all_by_id(p.industry_category_id).length==0 then hasitems=true end    
    end

    for s in self.services
      if self.industry_categories.find_all_by_id(s.industry_category_id).length==0 then hasitems=true end    
    end

    errors.add :IndustryCategories, I18n.t('errors.messages.has_items') if hasitems
	end
	
	def services_and_products_count
		self.services.count + self.products.count
	end
	
	def add_supplier_page_view(ip, type_name = 'Presentacion')
	  type = ViewCountType.find_by_name type_name
		supplier_page_view = supplier_page_views.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month, :ip => ip, view_count_type_id: type.id).first || supplier_page_views.build(ip: ip, view_count_type_id: type.id)
		supplier_page_view.count.blank? ? supplier_page_view.count = 1 : supplier_page_view.count += 1
		supplier_page_view.save
	end
		
	private
	# Correct format for Rut (a string without "." or "-")
	def correct_rut_format
	  self.rut.gsub!(/[-]|[.]/, "") unless self.rut.blank?
 	end

	def correct_phone_number_format
		self.phone_number.gsub!(/[^\d^+]/, "") unless self.phone_number.blank?
 	end
 	
 	def self.user_reviewable(user_account)
 		supplier_accounts = []
		user_account.expenses.each do |exp|
			supplier_accounts << exp.supplier_account unless exp.supplier_account.blank?
		end
		#DZF dont repeat suppliers
		supplier_accounts.uniq
 	end
  
  def add_address_if_nil
    if self.address.nil?
        a = Address.new
        a.save
        self.address = a
        self.save(:validate => false)
      end
  end
  
  def delete_sub_ics_when_no_ic
   	self.sub_industry_categories.each do |sa_sub_ic|
       if !self.industry_categories.include?(sa_sub_ic.industry_category)
         self.sub_industry_categories.delete(sa_sub_ic)
       end
     end
   end
	
end
