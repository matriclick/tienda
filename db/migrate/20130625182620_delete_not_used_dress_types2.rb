class DeleteNotUsedDressTypes2 < ActiveRecord::Migration
  def up
    aux = DressType.where('name like "%boutique%" or name like "%bebe%" or name like "%novia%" or name like "%madrina%" or name like "%civil%"')
    aux.each do |dt|
      dt.dresses.each do |d|
        d.destroy
      end
      puts dt.name
      dt.destroy
    end
  end
  
  def down
  end
end
