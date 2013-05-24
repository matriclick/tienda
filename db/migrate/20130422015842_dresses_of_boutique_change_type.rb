class DressesOfBoutiqueChangeType < ActiveRecord::Migration
  def up
    DressType.find_by_name("vestidos-tienda-boutique") || DressType.create(:name => 'vestidos-tienda-boutique', :description => "Vestidos de tiendas boutique")
    
    tienda_boutique = SupplierAccountType.find_by_name("Vestidos Boutique")
    vestido_boutique = DressType.find_by_name("vestidos-tienda-boutique")
    
    tienda_boutique.supplier_accounts.each do |sa|
      puts '----------------------'
      puts sa.fantasy_name
      sa.dresses.each do |d|
        puts '----'
        puts d.dress_types.first.id
        d.dress_types.clear
        d.dress_types << vestido_boutique
        d.save
        puts d.dress_types.first.id
        puts '----'
      end
    end
  end

  def down
  end
end
