class AddMissingFieldsToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :introduction, :text
    add_column :dresses, :care, :text
    add_column :dresses, :refund, :text
  end
end
