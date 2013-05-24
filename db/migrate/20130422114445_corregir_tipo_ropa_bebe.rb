# encoding: UTF-8
class CorregirTipoRopaBebe < ActiveRecord::Migration
  def up
    nino = DressType.find_by_name("bebe - niño")
    nina = DressType.find_by_name("bebe - niña")
    unisex = DressType.find_by_name("bebe - unisex")
    znino = DressType.find_by_name("bebe - zapatos niño")    
    znina = DressType.find_by_name("bebe - zapatos niña")    
    
    nuevo_nino = DressType.find_by_name("ropa-bebe-niño")
    nuevo_nina = DressType.find_by_name("ropa-bebe-niña")
    nuevo_znino = DressType.find_by_name("zapatos-bebe-niño")
    nuevo_znina = DressType.find_by_name("zapatos-bebe-niña")
    
    unless nino.nil?
      nino.dresses.each do |d|
        d.dress_types.clear
        d.dress_types << nuevo_nino
        d.save
      end
    end
    
    unless nina.nil?
      nina.dresses.each do |d|
        d.dress_types.clear
        d.dress_types << nuevo_nina
        d.save
      end
    end
    
    unless unisex.nil?
      unisex.dresses.each do |d|
        d.dress_types.clear
        d.dress_types << nuevo_nino
        d.save
      end
    end
    
    unless znino.nil?
      znino.dresses.each do |d|
        d.dress_types.clear
        d.dress_types << nuevo_znino
        d.save
      end
    end

    unless znina.nil?
      znina.dresses.each do |d|
        d.dress_types.clear
        d.dress_types << nuevo_znina
        d.save
      end
    end
    
  end

  def down
  end
end
