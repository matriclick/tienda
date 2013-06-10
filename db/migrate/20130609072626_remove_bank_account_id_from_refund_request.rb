class RemoveBankAccountIdFromRefundRequest < ActiveRecord::Migration
  def up
    remove_column :refund_requests, :bank_account_id
  end

  def down
    add_column :refund_requests, :bank_account_id, :integer
  end
end
