# encoding: UTF-8
class SetDbForAguClick < ActiveRecord::Migration
  def up
    bebe_types = DressType.where('name like "Bebe %"')
    bebe_types.each do |bebe_type|
      bebe_type.dresses.each do |dress|
        dress.destroy
      end
      bebe_type.destroy
    end
    
    bebe_types = []
    bebe_types << DressType.find_or_create_by_name(:name => 'Bebe - Niño', :description => 'Ropa de Niño')
    bebe_types << DressType.find_or_create_by_name(:name => 'Bebe - Niña', :description => 'Ropa de Niña')
    bebe_types << DressType.find_or_create_by_name(:name => 'Bebe - Unisex', :description => 'Ropa Unisex para Niños')
    
    bebe_sizes = []
    bebe_sizes << Size.find_or_create_by_name(:name => '0 a 3 meses')
    bebe_sizes << Size.find_or_create_by_name(:name => '3 a 6 meses')
    bebe_sizes << Size.find_or_create_by_name(:name => '6 a 9 meses')
    bebe_sizes << Size.find_or_create_by_name(:name => '9 a 12 meses')
    bebe_sizes << Size.find_or_create_by_name(:name => '12 a 18 meses')
    bebe_sizes << Size.find_or_create_by_name(:name => '18 a 24 meses')
    bebe_sizes << Size.find_or_create_by_name(:name => '24 meses o más')
    
    bebe_types.each do |bebe_type|
      bebe_sizes.each do |bebe_size|
        bebe_type.sizes << bebe_size
      end
    end
  end
end
