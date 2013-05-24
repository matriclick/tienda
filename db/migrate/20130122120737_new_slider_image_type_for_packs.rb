# encoding: UTF-8
class NewSliderImageTypeForPacks < ActiveRecord::Migration
  def up
    SliderImageType.find_or_create_by_name(:name => 'Matri-packs', :description => 'Se muestra en el inicio de los Matri-Packs')
  end

  def down
    matri_packs_type = SliderImageType.find_by_name('Matri-packs')
    matri_packs_type.destroy if !matri_packs_type.nil?
  end
end
