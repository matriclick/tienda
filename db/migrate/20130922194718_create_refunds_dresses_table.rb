class CreateRefundsDressesTable < ActiveRecord::Migration
  def up
    create_table :dresses_refund_requests, :id => false do |t|
      t.integer :dress_id
      t.integer :refund_request_id
    end
  end

  def down
  end
end
