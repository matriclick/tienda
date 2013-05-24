class ServiceImage < ActiveRecord::Base
	before_validation :set_image_index_depending_on_active	
	before_destroy :set_image_index_after_destroy

  belongs_to :service
  
  has_attached_file :image, 
											:styles => {
												:thumb => "100x100>",
												:smaller => "120x90>",
												:small => "200x150>",
												:tiny => "40x40>"
  }, :whiny => false
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
  validates_attachment_size :image, :less_than => 2.megabytes
  
	
	def self.cover_first
		order("image_index")
	end

	def name
	  file_name = self.image_file_name
	  return file_name[0..file_name.index('.')-1].gsub('-', ' ')
  end

	# FGM: Get all the images and remove the cover
	def self.without_cover
		images = cover_first
		images.slice!(0)
		images
	end

  def self.active
    where(:active => true)
  end

  def self.inactive
    where(:active => false)
  end

  private
  
  # FGM: Will set image_index for new PlaceImage based on existing ones (other PlaceImages for the same Place).
  def set_image_index_depending_on_active
    unless service.nil?
      if self.active && self.image_index.nil?
        self.service.service_images.active.blank? ? self.image_index = 1 : self.image_index = self.service.service_images.active.count + 1
      elsif !self.active
        self.image_index = nil
      end
    end
  end
  
  def set_image_index_after_destroy
	  if !self.image_index.nil?
  		self.service.service_images.each do |pi|
  		  if pi.image_index.nil?
  	      pi.image_index = 1
        end
				if pi.image_index > self.image_index
					pi.update_attributes(:image_index => pi.image_index - 1)	
				end
			end
		end
	end	
end
