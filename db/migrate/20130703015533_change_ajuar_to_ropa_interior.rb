class ChangeAjuarToRopaInterior < ActiveRecord::Migration
  def up
    dt = DressType.find_by_name("ajuar")
    dt.name = 'ropa-interior'
    dt.save
  end

  def down
    dt = DressType.find_by_name("ropa-interior")
    dt.name = 'ajuar'
    dt.save
  end
end
