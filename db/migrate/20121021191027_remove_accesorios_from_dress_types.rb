class RemoveAccesoriosFromDressTypes < ActiveRecord::Migration
  def up
    acc = DressType.find_by_name("Accesorio")
    if !acc.nil?
      acc.destroy
    end
    
    bb = DressType.find_by_name("Bebe")
    if !bb.nil?
      bb.destroy
    end
    
  end

  def down
  end
end
