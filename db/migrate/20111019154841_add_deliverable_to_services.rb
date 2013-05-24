class AddDeliverableToServices < ActiveRecord::Migration
  def change
    add_column :services, :deliverable, :boolean
    add_column :services, :name, :string
  end
end
