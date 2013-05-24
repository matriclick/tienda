class AddRepresentativeToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :representative, :string
  end
end
