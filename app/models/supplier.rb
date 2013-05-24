class Supplier < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable

  include CountryMethods

  after_create :set_country_id_with_locale
	after_create :ensure_supplier_account_exists
	after_create :send_welcome_email

	has_one :supplier_account, :dependent => :destroy
	belongs_to :country
  has_many :star_ratings, :as => :rateable
	
	validates :email, :email => true
	
	attr_accessible :email, :password, :password_confirmation, :remember_me, :language
 
  def ensure_supplier_account_exists
	  if supplier_account.blank?
		  # FGM: Generate account
		  self.build_supplier_account
		  # FGM: We'll skip validations the first time. The user will have to fill the account data to continue.. (application_controller :before_filter)
		  self.supplier_account.save :validate => false
	  end
	  self.supplier_account.presentation = Presentation.create
  end

  def send_welcome_email
    SupplierMailer.welcome_email(self).deliver
  end
  
  def alvi?
		self.email == 'agmarin@matriclick.com'
	end
	
  def developer?
		['magdalena@matriclick.com', 'felbalart@gmail.com'].include?(self.email)
	end
	
end
