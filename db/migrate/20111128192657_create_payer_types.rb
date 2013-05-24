class CreatePayerTypes < ActiveRecord::Migration
  def change
    create_table :payer_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
