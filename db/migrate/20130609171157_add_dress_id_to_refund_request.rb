class AddDressIdToRefundRequest < ActiveRecord::Migration
  def change
    add_column :refund_requests, :dress_id, :integer
  end
end
