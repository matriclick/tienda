class Service < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
	before_validation :ensure_schedule_exists
	after_validation :geocode, :if => :address_changed?
	after_create :set_service_images_index, :send_warning_email
	after_update :send_warning_email
	after_save :re_order_to_prevent_duplicated_indexes

	has_one :schedule, :dependent => :destroy
	belongs_to :supplier_account
	belongs_to :industry_category
	belongs_to :color_type
	has_many :service_images, :dependent => :destroy
	has_many :events, :dependent => :destroy
	has_many :service_budgets, :dependent => :destroy
	has_many :service_faqs, :dependent => :destroy
	has_many :conversations, :as => :conversable, :dependent => :destroy
	has_many :budgets, :as => :budgetable, :dependent => :destroy
	has_many :star_ratings, :as => :rateable
	has_many :reviews, :as => :reviewable
	has_many :bookings, :as => :bookable
	has_many :no_more_bookings, :as => :no_more_bookable
	has_many :videos, :as => :videoable, :dependent => :destroy
	has_many :purchases, :as => :purchasable
  
  validates :name, :contact_phone, :industry_category_id, :presence => true
	validates :name, :length => { :maximum => 30 }
	validates :contact_phone, :numericality => true
	validates :address, :commune, :presence => true, :unless => :is_deliverable
	validates :price_description, :length => { :maximum => 20 }
	validates :service_images, :presence => true
	validate :belongs_to_industry_category_type
	validates_numericality_of :price, :top_price_range
	# TODO: Figure this out
	# validate :booking_resources_consumed_cant_exceed_account_booking_resources
	
	accepts_nested_attributes_for :service_images, :reject_if => proc { |a| a[:image].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :service_faqs, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :videos, :reject_if => proc {|a| a[:url_code].blank?}, :allow_destroy => true
  attr_accessible :deliverable, :discount, :industry_category_id, :name, :address, :latitude, :longitude, :max_capacity, :contact_phone, :rent_cost, :commune, :service_images_attributes, :color_type_id, :max_bookings, :max_confirmed_bookings, :parking, :price, :price_description, :top_price_range, :description, :service_faqs_attributes, :videos_attributes, :booking_resources_consumed, :place

	geocoded_by :address
	
	def booking_resources_consumed_cant_exceed_account_booking_resources
		errors.add(:booking_resources_consumed, "No puede exceder la cantidad de recursos definidos en tu perfil (#{self.supplier_account.booking_resources}).") if self.booking_resources_consumed > self.supplier_account.booking_resources
	end

  def belongs_to_industry_category_type
    unless ["Servicios", "Servicios a Domicilio"].include? industry_category.industry_category_type.name
    	errors.add(:industry_category_id, "debe pertenecer a un rubro de servicios")
    end
  end

	def self.by_industry_category(id)
		if id
			where(:industry_category_id => id)
		else
			scoped
		end
	end
	
  def send_warning_email
  	unless self.top_price_range == 0
  		NoticeMailer.service_email(self).deliver if check_prices == true
  	end
  end
	
  def check_prices #DZF definir diferencia de precios a mandar warning mail 15
		industry_category_id = self.industry_category.id
		case industry_category_id
			when 13
				return true if (self.top_price_range - self.price > 15000 )
			when 3
				return true if (self.top_price_range - self.price > 100000 )
			when 28
				return true if (self.top_price_range - self.price > 150000 )
			when 18
	 			return true if (self.top_price_range - self.price > 200000 )
			when 4, 16, 20, 15, 17, 22
				return true if (self.top_price_range - self.price > 300000 )
			when 14
				return true if (self.top_price_range - self.price > 400000 )
			when 24, 23
				return true if (self.top_price_range - self.price > 500000 )
			when 25, 12
				return true if (self.top_price_range - self.price > 1000000 )
			else
				return false
  	end	
  end
	
	def self.search(search)
		unless search == 'all'
		  where(:industry_category_id => search)
		else
		  scoped
		end
	end
	
	def self.approved
	  joins(:supplier_account).where("supplier_accounts.approved_by_us = true && supplier_accounts.approved_by_supplier = true")
  end

	def self.alphabetized
		order(:name => :asc)
	end
	
	def add_to_budget(budget_price, budget_type_id, user_account)
		budget_slot = user_account.budget_slots.where(budget_type_id: budget_type_id, industry_category_id: self.industry_category_id).first
		budget = budgets.where(budget_type_id: budget_type_id, user_account_id: user_account.id).first || Budget.create!(budget_type_id: budget_type_id, user_account_id: user_account.id, budget_slot_id: budget_slot.id)
		
		if budget_price.present?
			budget_price.to_i > 0 && budget_price.to_i != self.price && budget_price.to_i != self.top_price_range ? budget.price = budget_price.to_i : budget.price = nil
		end
		
		self.budgets << budget
	end

	def is_deliverable
		deliverable == true
	end

	def belongs_to_budget_type?(user_account, budget_type)
		return true if service_budgets.where(:user_account_id => user_account, :budget_type_id => budget_type).present?
		false
	end

	def has_no_more_booking?(date)
		no_more_bookings.find_by_date(date).present?
	end
		
	def fits_in_bookings_waiting_list?(date)
		waiting_list_consumed_resources = self.supplier_account.bookables(:date => date).map{ |b| b.bookings.where(date: date).by_status(status: [:pending, :custom]).count * b.booking_resources_consumed }.sum

		self.booking_resources_consumed <= self.supplier_account.booking_waiting_list_size - waiting_list_consumed_resources
	end
	
	# -------------- PURCHASABLE METHODS -------------------
	
	# def description --> NO ES NECESARIO YA QUE EXISTE EL ATRIBUTO
  # def price --> NO ES NECESARIO YA QUE EXISTE EL ATRIBUTO
  # def supplier_account --> NO ES NECESARIO YA QUE EXISTE LA RELACIÓN
  
  def main_image
    self.service_images.active.cover_first.first.image.url(:small)
  end
  
  
  def refund
  end
  
  def small_image
    self.service_images.active.cover_first.first.image.url(:smaller)
  end
  
  def mark_as_sold
  end
  
  def mark_as_used
  end
  
  # For the methods "link_to_view" and "full_link_to_view", the line "include Rails.application.routes.url_helpers" must be present in the model in order to use the "_path" and "_url" methods.
  def link_to_view(country_url_path, purchase_id = nil)
    products_and_services_catalog_description_path(:id => self.id, :object_class => self.class, :country_url_path => country_url_path)
  end
  
  def full_link_to_view(country_url_path, purchase_id = nil)
    host = 'www.matriclick.com'
    products_and_services_catalog_description_path(:id => self.id, :object_class => self.class, :only_path => false, :host => host, :country_url_path => country_url_path)
  end
  # -------------- END PURCHASABLE METHODS -------------------
  
	private
	def ensure_schedule_exists
		if schedule.blank?
			self.build_schedule
		end
	end

	def set_service_images_index
		self.service_images.count.times do |index|
			self.service_images[index].update_attribute :image_index, index + 1
		end
	end
	
	def re_order_to_prevent_duplicated_indexes
		# FGM: Check ServiceImages with the same index.
		unless self.service_images.blank?
			if self.service_images.where("service_images.image_index = ?", self.service_images.last.image_index).count > 1
				self.service_images.where("service_images.image_index = ?", self.service_images.last.image_index).each_with_index do |service_image, index|
					service_image.update_attribute :image_index, service_image.image_index + index
				end
			end
		end
	end
	
	def self.by_conversations(conversations)
		services = []
		conversations.each do |conversation|
			services << Service.find(conversation.service_id)
		end
		return services
	end
	# -------------- END PURCHASABLE METHODS -------------------
    
end
