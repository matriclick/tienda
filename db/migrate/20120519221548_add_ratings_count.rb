class AddRatingsCount < ActiveRecord::Migration
  def up
    add_column :supplier_accounts, :reviews_count, :integer, :default => 0

    SupplierAccount.reset_column_information

    SupplierAccount.find(:all).each do |s|
      SupplierAccount.update_counters s.id, :reviews_count => s.reviews.length
    end
  end

  def down
    remove_column :supplier_accounts, :reviews_count
  end
end
