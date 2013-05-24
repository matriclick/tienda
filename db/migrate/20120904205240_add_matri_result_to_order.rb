class AddMatriResultToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :matri_result, :string
  end
end
