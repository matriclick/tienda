class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :i18n]

  belongs_to :country
  has_many :post_contents
  
  has_attached_file :main_image, :styles => {
                 :tiny => "40x40>",
                 :thumb => "100x100>",
                 :home_page => "300x200>",
                 :main => "1140x>",
  }, :whiny => false, :dependent => :destroy
  validates_attachment_size :main_image, :less_than => 7.megabytes
  
  accepts_nested_attributes_for :post_contents, :reject_if => proc { |a| a[:content].blank? }, :allow_destroy => true
  
  
  def self.find_last(position)
    posts = Post.is_visible.order('id DESC').limit(3)
    return posts[position]
  end
  
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
