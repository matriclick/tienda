class AllDressesAreAvailable < ActiveRecord::Migration
  def up
    DressStatus.create(:name => 'Disponible', :description => 'Queda stock y se puede ver')
    
    dresses = Dress.all
    available_id = DressStatus.find_by_name("Disponible").id
    dresses.each do |dress|
      dress.update_attribute(:dress_status_id, available_id)
    end
  end

  def down
  end
end
