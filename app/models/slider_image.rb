class SliderImage < ActiveRecord::Base
  include CountryMethods
  after_create :set_country_id_with_locale
  
  belongs_to :country
  belongs_to :slider_image_type
  
  has_attached_file :slider_image, :styles => {
		:thumb => "100x100>",
		:small => "200x150>",
		:tiny => "40x40>"
	}, :whiny => false
	
	validates :slider_image, :presence => true
		
	def self.by_type(name = nil)
    joins(:slider_image_type).where("slider_image_types.name = '#{name}'") unless name.nil?
	end
	
	def name
	  file_name = self.slider_image_file_name
	  return file_name[0..file_name.index('.')-1].gsub('-', ' ')
  end
  
end
