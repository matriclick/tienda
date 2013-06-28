class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, :confirmable
  devise :database_authenticatable, :registerable, :omniauthable, 
         :recoverable, :rememberable, :trackable, :validatable
  
  include CountryMethods

  after_create :set_country_id_with_locale
  after_create :check_if_is_matriclicker
  after_create :ensure_user_account_exists
	
	has_one :wedding_planner_quote, :dependent => :destroy
	has_many :contest_travelites, :dependent => :destroy
	has_many :refund_requests, :dependent => :destroy
	has_one :matriclicker, :dependent => :destroy
  belongs_to :country
	belongs_to :role
	has_many :reviews, :dependent => :destroy
	belongs_to :user_account, :dependent => :destroy
	belongs_to :cloth_measure, :dependent => :destroy
  has_and_belongs_to_many :tags
  
	has_many :conversations, :dependent => :destroy
	has_many :supplier_accounts, :through => :conversations
	has_many :dress_requests, :dependent => :destroy
	has_many :purchases, :dependent => :destroy
	has_many :orders, :dependent => :destroy
	has_many :delivery_infos, :dependent => :destroy
	has_many :user_contest_selections, :dependent => :destroy
	has_many :credits, :dependent => :destroy
	has_many :shopping_carts, :dependent => :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :language, :tag_ids
	
	def self.get_all_with_tag
    joins(:tags).all.uniq
  end
  
	def check_if_has_credits
    self.credits.is_active.count > 0 ? true : false
  end
  
  def contest_despedida_de_soltera
    self.contest_travelites.where(:selection => 'despedida_de_soltera').first
  end
  
  def email_name
    self.email[0..self.email.index('@')-1]
  end
  
  def purchased_dresses
    products = Array.new
    self.purchases.each do |pur|
      if pur.purchasable_type == 'Dress' and !pur.purchasable.nil?
        unless pur.purchasable.nil?
          products.push(pur.purchasable)
        end
      elsif pur.purchasable_type == 'ShoppingCart' and !pur.purchasable.nil?
        unless pur.purchasable.shopping_cart_items.nil?
          pur.purchasable.shopping_cart_items.each do |sci|
            if pur.purchasable_type == 'Dress'
              products.push(sci.purchasable)
            end
          end
        end
      end
    end
    return products
  end
  
  def credit_amount
    total = 0
    self.credits.is_active.each do |ac|
      total = total + ac.available_credit
    end
    return total
  end
	
	def check_if_is_matriclicker
	  if self.email.include? '@matriclick'
	    self.role_id = 1
	    self.save
    end
  end
  
	def self.owner
		where(:is_owner => true)
	end
	
	#Be sure to create the users with the info you need.
  #Note that facebook and gmail will give you different info from users
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_google(access_token, signed_in_resource=nil)
    data = access_token['user_info']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end
  
	def admin?
		role.try(:name) == "admin"
	end

	def alvi?
		self.email == 'agmarin@gmail.com'
	end
	
	def developer?
		['hhanckes@gmail.com', 'rodrigo.fuentes.z@gmail.com'].include?(self.email)
	end
	
	def guest?
		role.try(:name) == "guest"
	end

  def send_user_email
    UserMailer.user_email(self).deliver
  end

	def ensure_user_account_exists
		if user_account.blank?
			self.build_user_account
			self.is_owner = true #DZF if is the first user, then is the owner of the user_account
			self.save :validate => false
		end
	end
	
	def select_current_shopping_cart
	  self.shopping_carts.is_active.count > 0 ? self.shopping_carts.is_active.first : ShoppingCart.create(:user_id => self.id, :active => true)
  end
    
  def cart_items
	  if self.shopping_carts.is_active.count > 0 
	     self.shopping_carts.is_active.first.shopping_cart_items.size > 0 ? self.shopping_carts.is_active.first.shopping_cart_items.size : false
    else
      false
    end
  end
  
end
