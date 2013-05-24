# coding: utf-8
class DeleteUnUsedDressTypes < ActiveRecord::Migration
  def up
    types = ['novia','fiesta','madrina','aros','anillos','collares','pulseras','carteras','sombreros','carcasas','bebe niño','bebe niña','bebe zapatos niño','bebe zapatos niña','mujer - poleras','mujer - blusas','mujer - pantalones','mujer - jeans','mujer - leggins', 'mujer - panties', 'mujer - shorts', 'mujer - chalecos', 'mujer - polerones', 'mujer - chaquetas', 'tu casa - cerámicas', 'tu casa - cubrecamas', 'bebe - unisex']
    
    types.each do |n|
      puts n.to_s
      dt = DressType.find_by_name(n.to_s)
      if !dt.nil?
        puts dt.name+': '+dt.dresses.size.to_s    
        dt.destroy if dt.dresses.size == 0
      end
    end
    
  end

  def down
  end
end
