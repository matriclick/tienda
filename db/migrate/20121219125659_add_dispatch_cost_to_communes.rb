# encoding: UTF-8
class AddDispatchCostToCommunes < ActiveRecord::Migration
  def up
    add_column :communes, :dispatch_cost, :integer
    
    regions = Region.all
    regions.each do |region|
      case region.name
        when 'I - Tarapacá'
          region.communes.each do |commune|
            commune.dispatch_cost = 4100
            commune.save
          end
        when 'II - Antofagasta'
          region.communes.each do |commune|
            commune.dispatch_cost = 4450
            commune.save
          end
        when 'III - Atacama'
          region.communes.each do |commune|
            commune.dispatch_cost = 3600
            commune.save
          end
        when 'IV - Coquimbo'
          region.communes.each do |commune|
            commune.dispatch_cost = 3600
            commune.save
          end
        when 'V - Valparaíso'
          region.communes.each do |commune|
            commune.dispatch_cost = 3500
            commune.save
          end
        when 'VI - O’Higgins'
          region.communes.each do |commune|
            commune.dispatch_cost = 4200
            commune.save
          end
        when 'VII - Maule'
          region.communes.each do |commune|
            commune.dispatch_cost = 3500
            commune.save
          end
        when 'VIII - Biobío'
          region.communes.each do |commune|
            commune.dispatch_cost = 3500
            commune.save
          end
        when 'IX - Araucanía'
          region.communes.each do |commune|
            commune.dispatch_cost = 3600
            commune.save
          end
        when 'X - Los Lagos'
          region.communes.each do |commune|
            commune.dispatch_cost = 3950
            commune.save
          end
        when 'XI - Aysén'
          region.communes.each do |commune|
            commune.dispatch_cost = 5000
            commune.save
          end
        when 'XII - Magallanes'
          region.communes.each do |commune|
            commune.dispatch_cost = 5000
            commune.save
          end
        when 'XIV - Los Ríos'
          region.communes.each do |commune|
            commune.dispatch_cost = 3600
            commune.save
          end
        when 'XV - Arica y Parinacota'
          region.communes.each do |commune|
            commune.dispatch_cost = 4100
            commune.save
          end
        when 'RM - Metropolitana'
          region.communes.each do |commune|
            case commune.name
              when 'Las Condes', 'Lo Barnechea', 'Ñuñoa', 'Providencia', 'Vitacura'
                commune.dispatch_cost = 0
                commune.save
              else
                commune.dispatch_cost = 2300
                commune.save
            end
          end
      end
    end
  end
  
  def down
    remove_column :communes, :dispatch_cost
  end
end
