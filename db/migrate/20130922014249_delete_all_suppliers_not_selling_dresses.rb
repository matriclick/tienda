class DeleteAllSuppliersNotSellingDresses < ActiveRecord::Migration
  def up
    Supplier.all.each do |s|
      s.destroy if s.supplier_account.dresses.size == 0
    end
  end

  def down
  end
end
