class AddLanguageToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :language, :string
  end
end
