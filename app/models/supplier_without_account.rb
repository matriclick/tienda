class SupplierWithoutAccount < ActiveRecord::Base
  belongs_to :industry_category
  has_attached_file :image, 
											:styles => {
												:thumb => "100x100>",
												:small => "200x150>",
												:smaller => "120x90>",
												:profile_info => "130x70>",
												:tiny => "40x40>"
											}, :whiny => false
	
	def image_name
    file_name = self.image_file_name
	  return file_name[0..file_name.index('.')-1].gsub('-', ' ')
  end

end
