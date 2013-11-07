class RemoveSuppliersAccountsEmpty < ActiveRecord::Migration
  def up
    SupplierAccount.where('fantasy_name is null').each do |sa|
      sa.destroy
    end
  end

  def down
  end
end
