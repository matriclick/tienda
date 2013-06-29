class Post < ActiveRecord::Base
  include CountryMethods
  self.per_page = 8
  
  after_create :set_country_id_with_locale
  
  belongs_to :country
  belongs_to :industry_category
  has_many :blog_comments, :dependent => :destroy
  has_many :post_contents, :dependent => :destroy
  has_and_belongs_to_many :pack_promotions
  
  has_attached_file :main_image, :styles => {
                 :thumb => "100x100>",
                 :smaller => "120x90>",
                 :small => "200x150>",
                 :home_page => "300x200>",
                 :regular => "350x250>",
                 :tiny => "40x40>"
  }, :whiny => false, :dependent => :destroy
  validates_attachment_size :main_image, :less_than => 7.megabytes
  
  accepts_nested_attributes_for :post_contents, :reject_if => proc { |a| a[:content].blank? }, :allow_destroy => true
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :i18n]
  	
  def self.by_industry_category(id, name = nil)
		if id
			joins(:industry_category).where("industry_categories.id = #{id}")
		elsif name
			joins(:industry_category).where("industry_categories.name = #{name}")
		else
			scoped
		end
	end
	
	def self.not_id(id)
		where("posts.id <> #{id}")
	end
	
	def self.is_visible()
	  where("visible = true")
  end
	
	def main_image_name
	  file_name = self.main_image_file_name
	  return file_name[0..file_name.index('.')-1].gsub('-', ' ')
  end
  
end
