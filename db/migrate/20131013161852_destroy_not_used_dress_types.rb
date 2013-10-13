class DestroyNotUsedDressTypes < ActiveRecord::Migration
  def up
    DressType.where('name like "%accesorios%"').each do |dt|
      puts dt.name
      dt.destroy
    end
    DressType.where('name like "%deportiva%"').each do |dt|
      puts dt.name
      dt.destroy
    end
  end

  def down
  end
end
