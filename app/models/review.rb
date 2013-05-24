class Review < ActiveRecord::Base
	belongs_to :reviewable, :polymorphic => true
	has_one :star_rating, :as => :rateable, :dependent => :destroy
	belongs_to :supplier_account
	after_create :send_review_email
	before_create :check_if_admin_is_creating
  belongs_to :user
  #after_update :update_reviews_count
  
	validates :content, :presence => true
	
	accepts_nested_attributes_for :star_rating, :reject_if => lambda { |a| a[:value].blank? }, :allow_destroy => true
	
	def self.by_user_id(user_id)
		where(:user_id => user_id)
	end
  
  def check_if_admin_is_creating
    if self.user.role_id == 1
      self.approved_by_admin = true
    end
  end
  
  def send_review_email
    NoticeMailer.review_email(self).deliver
  end
  
  def update_reviews_count
    self.supplier_account.reviews_count = Review.where(:supplier_account_id => self.supplier_account_id, :approved => true).count()
  end
  
  def is_approved?
		self.approved_by_admin
	end
	
	def self.approved
		where(:approved_by_admin => true)
	end
	
end
