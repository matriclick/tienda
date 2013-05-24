# encoding: UTF-8
class StartAndEndDatesForPackPromotions < ActiveRecord::Migration
  def change
    add_column :pack_promotions, :start_date, :date
    add_column :pack_promotions, :end_date, :date
  end
end