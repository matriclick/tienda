class RemoveRepresentativeAndAddSupplierContactsForSupplier < ActiveRecord::Migration
  def up
		remove_column :suppliers, :representative
  end

  def down
		add_column :suppliers, :representative, :string
  end
end
