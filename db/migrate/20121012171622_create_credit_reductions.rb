class CreateCreditReductions < ActiveRecord::Migration
  def change
    create_table :credit_reductions do |t|
      t.integer :credit_id
      t.integer :purchase_id
      t.integer :value
      t.date :used_date

      t.timestamps
    end
  end
end
