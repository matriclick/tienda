class AlbumPhoto < ActiveRecord::Base
  belongs_to :album
  has_many :album_photos
  
  has_attached_file :album_photo_image, 
										  :styles => {
										    :album_photo_size => "220x"
	}, :whiny => false
	validates_attachment_content_type :album_photo_image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
  validates_attachment_size :album_photo_image, :less_than => 1.megabytes
	
  def self.visible
    where('visible = 1 and album_photo_image_file_name is not null and album_photo_image_file_name <> ""')
  end
  
  def visible?
    if self.album_photo_image.blank?
      return false
    else
      return self.visible
    end
  end
  
	def name
	  file_name = self.album_photo_image_file_name
	  return file_name[0..file_name.index('.')-1].gsub('-', ' ')
  end

end
