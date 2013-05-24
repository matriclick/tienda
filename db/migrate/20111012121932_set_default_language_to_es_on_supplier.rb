class SetDefaultLanguageToEsOnSupplier < ActiveRecord::Migration
  def change
		change_column :suppliers, :language, :string, :default => "es"
  end
end
