class AddViewCountTypeIdToSupplierPageViews < ActiveRecord::Migration
  def change
    add_column :supplier_page_views, :view_count_type_id, :integer
  end
end
