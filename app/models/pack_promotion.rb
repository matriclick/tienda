class PackPromotion < ActiveRecord::Base
  has_and_belongs_to_many :posts
  
  has_attached_file :pack_promotion_image, 
											:styles => {
												:small => "120x",
												:tiny => "40x"
	}, :whiny => false
  validates_attachment_content_type :pack_promotion_image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
  validates_attachment_size :pack_promotion_image, :less_than => 2.megabyte
	
	def applicable
	  if !self.applicable_type.blank? and !self.applicable_id.blank?
      return eval(self.applicable_type.to_s + '.find ' + self.applicable_id.to_s)
    else
      return nil
    end
  end
  
end
