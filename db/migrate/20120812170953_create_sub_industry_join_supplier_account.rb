class CreateSubIndustryJoinSupplierAccount < ActiveRecord::Migration
  def up
    
    drop_table :sub_industry_categories_supplier_accounts
    
    create_table :sub_industry_categories_supplier_accounts, :id => false do |t|
      t.integer  :sub_industry_category_id
      t.integer  :supplier_account_id

      t.timestamps
    end
    
  end

  def down
  end
end
