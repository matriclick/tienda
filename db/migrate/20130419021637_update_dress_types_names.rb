# coding: utf-8
class UpdateDressTypesNames < ActiveRecord::Migration
  def up
    puts "--> Dress Types:"
    aux = []
    aux << (DressType.find_by_name("Vestidos-Novia") || DressType.create(:name => 'Vestidos-Novia', :description => "Vestidos de novia"))
    aux << (DressType.find_by_name("Vestidos-Fiesta") || DressType.create(:name => 'Vestidos-Fiesta', :description => "Vestidos para la fiesta"))
    aux << (DressType.find_by_name("Vestidos-Madrina") || DressType.create(:name => 'Vestidos-Madrina', :description => "Vestidos para la fiesta"))
    aux << (DressType.find_by_name("Vestidos-Civil") || DressType.create(:name => 'Vestidos-Civil', :description => "Vestidos para la ceremonia civil"))
    aux << (DressType.find_by_name("Zapatos") || DressType.create(:name => 'Zapatos', :description => "Zapatos para fiesta"))
    aux << (DressType.find_by_name("Accesorios-Aros") || DressType.create(:name => 'Accesorios-Aros', :description => "Accesorios para fiesta"))
    aux << (DressType.find_by_name("Accesorios-Anillos") || DressType.create(:name => 'Accesorios-Anillos', :description => "Accesorios para fiesta"))
    aux << (DressType.find_by_name("Accesorios-Collares") || DressType.create(:name => 'Accesorios-Collares', :description => "Accesorios para fiesta"))
    aux << (DressType.find_by_name("Accesorios-Pulseras") || DressType.create(:name => 'Accesorios-Pulseras', :description => "Accesorios para fiesta"))
    aux << (DressType.find_by_name("Accesorios-Carteras") || DressType.create(:name => 'Accesorios-Carteras', :description => "Accesorios para fiesta"))
    aux << (DressType.find_by_name("Accesorios-Sombreros") || DressType.create(:name => 'Accesorios-Sombreros', :description => "Accesorios para fiesta"))
    aux << (DressType.find_by_name("Accesorios-Carcasas") || DressType.create(:name => 'Accesorios-Carcasas', :description => "Carcasas para celulares"))

    aux << (DressType.find_by_name("Ropa-de-Mujer-Poleras") || DressType.create(:name => 'Ropa-de-Mujer-Poleras', :description => "Poleras mujer"))
    aux << (DressType.find_by_name("Ropa-de-Mujer-Blusas") || DressType.create(:name => 'Ropa-de-Mujer-Blusas', :description => "Blusas mujer"))
    aux << (DressType.find_by_name("Ropa-de-Mujer-Pantalones") || DressType.create(:name => 'Ropa-de-Mujer-Pantalones', :description => "Pantalones mujer"))
    aux << (DressType.find_by_name("Ropa-de-Mujer-Jeans") || DressType.create(:name => 'Ropa-de-Mujer-Jeans', :description => "Jeans mujer"))
    aux << (DressType.find_by_name("Ropa-de-Mujer-Leggins") || DressType.create(:name => 'Ropa-de-Mujer-Leggins', :description => "Leggins mujer"))
    aux << (DressType.find_by_name("Ropa-de-Mujer-Panties") || DressType.create(:name => 'Ropa-de-Mujer-Panties', :description => "Panties mujer"))
    aux << (DressType.find_by_name("Ropa-de-Mujer-Shorts") || DressType.create(:name => 'Ropa-de-Mujer-Shorts', :description => "Shorts mujer"))
    aux << (DressType.find_by_name("Ropa-de-Mujer-Chalecos") || DressType.create(:name => 'Ropa-de-Mujer-Chalecos', :description => "Chalecos mujer"))
    aux << (DressType.find_by_name("Ropa-de-Mujer-Polerones") || DressType.create(:name => 'Ropa-de-Mujer-Polerones', :description => "Polerones mujer"))
    aux << (DressType.find_by_name("Ropa-de-Mujer-Chaquetas") || DressType.create(:name => 'Ropa-de-Mujer-Chaquetas', :description => "Chaquetas mujer"))

    aux << (DressType.find_by_name("Ropa-Bebe-Niño") || DressType.create(:name => 'Ropa-Bebe-Niño', :description => "Niño"))
    aux << (DressType.find_by_name("Ropa-Bebe-Niña") || DressType.create(:name => 'Ropa-Bebe-Niña', :description => "Niña"))
    aux << (DressType.find_by_name("Zapatos-Bebe-Niño") || DressType.create(:name => 'Zapatos-Bebe-Niño', :description => "Zapatos Niño"))
    aux << (DressType.find_by_name("Zapatos-Bebe-Niña") || DressType.create(:name => 'Zapatos-Bebe-Niña', :description => "Zapatos Niña"))

    aux << (DressType.find_by_name("Tu-Casa-Living-Sillas") || DressType.create(:name => 'Tu-Casa-Living-Sillas'))
    aux << (DressType.find_by_name("Tu-Casa-Living-Mesas") || DressType.create(:name => 'Tu-Casa-Living-Mesas'))
    aux << (DressType.find_by_name("Tu-Casa-Living-Sillones") || DressType.create(:name => 'Tu-Casa-Living-Sillones'))
    aux << (DressType.find_by_name("Tu-Casa-Living-Sofás") || DressType.create(:name => 'Tu-Casa-Living-Sofás'))
    aux << (DressType.find_by_name("Tu-Casa-Comedor-Comedores") || DressType.create(:name => 'Tu-Casa-Comedor-Comedores'))
    aux << (DressType.find_by_name("Tu-Casa-Comedor-Sillas") || DressType.create(:name => 'Tu-Casa-Comedor-Sillas'))
    aux << (DressType.find_by_name("Tu-Casa-Comedor-Sillones") || DressType.create(:name => 'Tu-Casa-Comedor-Sillones'))
    aux << (DressType.find_by_name("Tu-Casa-Dormitorio-Accesorios") || DressType.create(:name => 'Tu-Casa-Dormitorio-Accesorios'))
    aux << (DressType.find_by_name("Tu-Casa-Dormitorio-Cubrecamas") || DressType.create(:name => 'Tu-Casa-Dormitorio-Cubrecamas'))
    aux << (DressType.find_by_name("Tu-Casa-Home-Office") || DressType.create(:name => 'Tu-Casa-Home-Office'))
    aux << (DressType.find_by_name("Tu-Casa-Cocina-Accesorios") || DressType.create(:name => 'Tu-Casa-Cocina-Accesorios'))
    aux << (DressType.find_by_name("Tu-Casa-Cocina-Cerámicas") || DressType.create(:name => 'Tu-Casa-Cocina-Cerámicas'))
    aux << (DressType.find_by_name("Tu-Casa-Terraza-Muebles") || DressType.create(:name => 'Tu-Casa-Terraza-Muebles'))
    aux << (DressType.find_by_name("Tu-Casa-Terraza-Accesorios") || DressType.create(:name => 'Tu-Casa-Terraza-Accesorios'))
    aux << (DressType.find_by_name("Tu-Casa-Decoración-Cuadros") || DressType.create(:name => 'Tu-Casa-Decoración-Cuadros'))
    aux << (DressType.find_by_name("Tu-Casa-Decoración-Iluminación") || DressType.create(:name => 'Tu-Casa-Decoración-Iluminación'))
    aux << (DressType.find_by_name("Tu-Casa-Decoración-Cortinas") || DressType.create(:name => 'Tu-Casa-Decoración-Cortinas'))
    aux << (DressType.find_by_name("Tu-Casa-Decoración-Alfombras") || DressType.create(:name => 'Tu-Casa-Decoración-Alfombras'))
    aux << (DressType.find_by_name("Tu-Casa-Decoración-Cojines") || DressType.create(:name => 'Tu-Casa-Decoración-Cojines'))

    aux.each { |x| puts x.name}
    puts "\n"    
  end

  def down
  end
end
