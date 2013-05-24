class AddFieldsToUserAccount < ActiveRecord::Migration
  def change
    add_column :user_accounts, :wedding_tentative_date, :date
    add_column :user_accounts, :wedding_city, :string
    add_column :user_accounts, :tentative_budget, :integer
    add_column :user_accounts, :receive_news, :boolean
    add_column :user_accounts, :receive_supplier_promotions, :boolean
    add_column :user_accounts, :show_my_phones, :boolean
  end
end
