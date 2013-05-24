# encoding: UTF-8
class FixRegionNames < ActiveRecord::Migration
  def up
    regions = Region.all

    regions.each do |region|
      case region.name
        when 'XIII - Los Ríos'
          region.name = 'XIV - Los Ríos'
        when 'XIV - Arica y Parinacota'
          region.name = 'XV - Arica y Parinacota'
      end
      region.save
    end
  end
  
  def down
    regions = Region.all

    regions.each do |region|
      case region.name
        when 'XIV - Los Ríos'
          region.name = 'XIII - Los Ríos'
        when 'XV - Arica y Parinacota'
          region.name = 'XIV - Arica y Parinacota'
      end
      region.save
    end
  end
end
