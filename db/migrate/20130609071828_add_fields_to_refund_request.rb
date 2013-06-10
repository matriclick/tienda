class AddFieldsToRefundRequest < ActiveRecord::Migration
  def change
    add_column :refund_requests, :account_owner_name, :string
    add_column :refund_requests, :account_owner_id, :string
    add_column :refund_requests, :account_owner_email, :string
    add_column :refund_requests, :account_bank, :string
    add_column :refund_requests, :account_type, :string
    add_column :refund_requests, :account_number, :string
  end
end
