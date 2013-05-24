class AllSliderImagesForChile < ActiveRecord::Migration
  def change
    chile = Country.find_by_name('Chile')
    if !chile.nil?
      SliderImage.unscoped.all.each do |slider_image|
        slider_image.country_id = chile.id
        slider_image.save
      end
    end
  end
end
