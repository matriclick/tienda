class AddPayerTypeIdToPayers < ActiveRecord::Migration
  def change
    add_column :payers, :payer_type_id, :integer
  end
end
