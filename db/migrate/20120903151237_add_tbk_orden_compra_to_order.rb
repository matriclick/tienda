class AddTbkOrdenCompraToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :tbk_orden_compra, :string
  end
end
