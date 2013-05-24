class AllDressesAreInThe999Position < ActiveRecord::Migration
  def up
    @dresses = Dress.all
    
    @dresses.each do |dress|
      dress.update_attribute :position, 99
    end
  end

  def down
  end
end
