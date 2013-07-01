class DeleteRefundReasons < ActiveRecord::Migration
  def up
    RefundReason.all.each do |rr|
      puts rr.name
      rr.destroy
    end
  end

  def down
  end
end
