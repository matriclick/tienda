class DeleteNotUsedColumnsInDress < ActiveRecord::Migration
  def up
    remove_column :dresses, :seller_name	
    remove_column :dresses, :seller_phone_number	
    remove_column :dresses, :seller_email
  end

  def down
  end
end
