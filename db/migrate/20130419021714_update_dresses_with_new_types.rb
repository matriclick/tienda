# coding: utf-8
class UpdateDressesWithNewTypes < ActiveRecord::Migration
  def up
    Dress.all.each do |dress|
      dress.dress_types.each do |dress_type|
        case dress_type.name
          when 'Novia'
            dress.dress_types << DressType.find_by_name("Vestidos-Novia")
            dress.dress_types.delete dress_type
          when 'Fiesta'
            dress.dress_types << DressType.find_by_name("Vestidos-Fiesta")
            dress.dress_types.delete dress_type
          when 'Madrina'
            dress.dress_types << DressType.find_by_name("Vestidos-Madrina")
            dress.dress_types.delete dress_type
          when 'Civil'
            dress.dress_types << DressType.find_by_name("Vestidos-Civil")
            dress.dress_types.delete dress_type
          when 'Aros'
            dress.dress_types << DressType.find_by_name("Accesorios-Aros")
            dress.dress_types.delete dress_type
          when 'Anillos'
            dress.dress_types << DressType.find_by_name("Accesorios-Anillos")
            dress.dress_types.delete dress_type
          when 'Collares'
            dress.dress_types << DressType.find_by_name("Accesorios-Collares")
            dress.dress_types.delete dress_type
          when 'Pulseras'
            dress.dress_types << DressType.find_by_name("Accesorios-Pulseras")
            dress.dress_types.delete dress_type
          when 'Carteras'
            dress.dress_types << DressType.find_by_name("Accesorios-Carteras")
            dress.dress_types.delete dress_type
          when 'Sombreros'
            dress.dress_types << DressType.find_by_name("Accesorios-Sombreros")
            dress.dress_types.delete dress_type
          when 'Carcasas'
            dress.dress_types << DressType.find_by_name("Accesorios-Carcasas")
            dress.dress_types.delete dress_type
          when 'Bebe Niño'
            dress.dress_types << DressType.find_by_name("Ropa-Bebe-Niño")
            dress.dress_types.delete dress_type
          when 'Bebe Niña'
            dress.dress_types << DressType.find_by_name("Ropa-Bebe-Niña")
            dress.dress_types.delete dress_type
          when 'Bebe Zapatos Niño'
            dress.dress_types << DressType.find_by_name("Zapatos-Bebe-Niño")
            dress.dress_types.delete dress_type
          when 'Bebe Zapatos Niña'
            dress.dress_types << DressType.find_by_name("Zapatos-Bebe-Niña")
            dress.dress_types.delete dress_type
        end
      end
      dress.save
      puts "--> # Tipos: "+dress.dress_types.size.to_s
    end
  end

  def down
  end
  
end