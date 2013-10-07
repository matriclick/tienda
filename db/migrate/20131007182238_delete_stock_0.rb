class DeleteStock0 < ActiveRecord::Migration
  def up
    DressStockSize.destroy_all(:stock => 0)
  end

  def down
  end
end
