class AddCodeToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :code, :string
  end
end
