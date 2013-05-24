# encoding: UTF-8
class SetSizesAndStock < ActiveRecord::Migration
  def up
    size_unica = Size.find_or_create_by_name(:name => 'Única')
    types_for_unica = DressType.where("name in ('Aros', 'Anillos', 'Collares', 'Pulseras', 'Carteras')")
    status_available = DressStatus.find_by_name('Disponible')
    
    types_for_unica.each do |dress_type|
      dress_type.sizes << size_unica if !dress_type.sizes.include?(size_unica)
      dress_type.dresses.where(:dress_status_id => status_available.id).each do |dress|
        DressStockSize.create(:dress_id => dress.id, :size_id => size_unica.id, :stock => 1)
      end
    end
    
  end

  def down
    size_unica = Size.find_by_name('Única')
    size_unica.destroy
  end
end
