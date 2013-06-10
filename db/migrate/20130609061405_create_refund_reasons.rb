class CreateRefundReasons < ActiveRecord::Migration
  def change
    create_table :refund_reasons do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
