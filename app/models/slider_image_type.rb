class SliderImageType < ActiveRecord::Base
    has_many :slider_images, :dependent => :destroy
    
end
