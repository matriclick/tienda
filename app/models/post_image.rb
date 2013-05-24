class PostImage < ActiveRecord::Base
  belongs_to :post_content
  
  has_attached_file :photo, :styles => {
		:thumb => "100x100>",
		:smaller => "120x90>",
		:small => "200x150>",
		:tiny => "40x40>"
	}, :whiny => false
  
  validates_attachment_size :photo, :less_than => 7.megabytes
  
  def name
	  file_name = self.photo_file_name
	  return file_name[0..file_name.index('.')-1].gsub('-', ' ')
  end
  
end
