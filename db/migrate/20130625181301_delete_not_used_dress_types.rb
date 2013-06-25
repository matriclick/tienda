class DeleteNotUsedDressTypes < ActiveRecord::Migration
  def up
    aux = DressType.where('name like "%tu-casa%" or name like "%bebe%"')
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
