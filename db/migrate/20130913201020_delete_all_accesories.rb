class DeleteAllAccesories < ActiveRecord::Migration
  def up
    dts = DressType.where("name like '%accesorios%'")
    dts.each do |dt|
      dt.dresses.each do |d|
        d.destroy
      end
    end
  end

  def down
  end
end
