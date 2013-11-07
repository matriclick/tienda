# encoding: UTF-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, :confirmable
  devise :database_authenticatable, :registerable, :omniauthable, 
         :recoverable, :rememberable, :trackable, :validatable
         
  after_create :check_if_is_matriclicker
  after_create :ensure_user_account_exists

	belongs_to :role
	belongs_to :user_account, :dependent => :destroy
	belongs_to :cloth_measure, :dependent => :destroy
  
	has_one :matriclicker, :dependent => :destroy

  has_many :contestants, :dependent => :destroy
	has_many :contest_travelites, :dependent => :destroy
	has_many :refund_requests, :dependent => :destroy
  has_many :dresses_users_wish_lists, :dependent => :destroy
  has_many :dresses, :through => :dresses_users_wish_lists    
	has_many :dress_requests, :dependent => :destroy
	has_many :purchases, :dependent => :destroy
	has_many :orders, :dependent => :destroy
	has_many :delivery_infos, :dependent => :destroy
	has_many :user_contest_selections, :dependent => :destroy
	has_many :credits, :dependent => :destroy
	has_many :shopping_carts, :dependent => :destroy
	has_many :contest_votes, :dependent => :destroy
  
  has_and_belongs_to_many :supplier_accounts
  has_and_belongs_to_many :tags

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :language, :tag_ids, :dress_id
	
  def self.to_csv(from, to)
  	header = ['Correo Usuario', 'Fecha Inscripción', '# Compras', '# Compras Finalizadas', 'Monto Compras Finalizadas', 
              'Créditos Disponibles', 'Fecha Última Compra', 'Fecha Último Ingreso', 'Cantidad de Ingresos']
    users = User.where('created_at >= ? and created_at <= ?', from, to).order 'created_at DESC'
  
    CSV.generate do |csv|
      csv << header
      users.each do |user|
        if user.purchases.where(:status => 'finalizado').size > 0
          csv << [user.email, user.created_at, user.purchases.size, user.purchases.where(:status => 'finalizado').size, user.purchases.where(:status => 'finalizado').sum(:price),
                user.credit_amount, user.purchases.where(:status => 'finalizado').last.created_at, user.current_sign_in_at, user.sign_in_count]
        else
          csv << [user.email, user.created_at, user.purchases.size, 0, 0, user.credit_amount, 'n/a', user.current_sign_in_at, user.sign_in_count]
        end
      end
    end
  end
  
	def is_first_purchase
	  self.purchases.where('purchases.status = "finalizado"').size == 1 ? true : false
  end
  
	def self.get_all_with_tag
    joins(:tags).all.uniq
  end
  
	def check_if_has_credits
    credits = self.credits.is_active
    if credits.size > 0
      credits.each do |cred|
        if cred.available_credit > 0
          return true
        end
      end
    end
    return false
  end
  
  def contest_despedida_de_soltera
    self.contest_travelites.where(:selection => 'despedida_de_soltera').first
  end
  
  def email_name
    self.email[0..self.email.index('@')-1]
  end
  
  def purchased_dresses(for_refund = false)
    
    if !for_refund
      purchases = self.purchases.where('status = "finalizado"')
    else
      @from = (DateTime.now - 5.days).utc
      purchases = self.purchases.where('status = "finalizado" and created_at >= ?', @from)
    end
    
    products = Array.new
    purchases.each do |pur|
      if pur.purchasable_type == 'Dress' and !pur.purchasable.nil?
        products.push(pur.purchasable)
      elsif pur.purchasable_type == 'ShoppingCart' and !pur.purchasable.nil?
        pur.purchasable.shopping_cart_items.each do |sci|
          products.push(sci.purchasable)
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
