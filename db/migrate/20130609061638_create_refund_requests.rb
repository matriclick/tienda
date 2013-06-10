class CreateRefundRequests < ActiveRecord::Migration
  def change
    create_table :refund_requests do |t|
      t.integer :refund_reason_id
      t.integer :user_id
      t.integer :bank_account_id
      t.text :description

      t.timestamps
    end
  end
end
