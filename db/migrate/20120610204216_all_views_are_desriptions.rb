class AllViewsAreDesriptions < ActiveRecord::Migration
  def up
    type = ViewCountType.find_by_name 'Presentacion'
    page_views = SupplierPageView.all
    
    page_views.each do |pv|
      pv.update_attribute :view_count_type_id, type.id
    end
    
  end

  def down
    page_views = SupplierPageView.all
    
    page_views.each do |pv|
      pv.update_attribute :view_count_type_id, nil
    end
  end
end
