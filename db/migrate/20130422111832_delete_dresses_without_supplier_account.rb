class DeleteDressesWithoutSupplierAccount < ActiveRecord::Migration
  def up
    dresses = Dress.where(:supplier_account_id => nil)
    
    dresses.each do |d|
      puts d.id
      d.destroy
    end
  end

  def down
  end
end
