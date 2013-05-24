class CreateViewCountType < ActiveRecord::Migration
  def change
    unless ViewCountType.table_exists?
      create_table :view_count_types do |t|
        t.string :name
        t.text :description
        t.timestamps
      end
    end
  end
end
