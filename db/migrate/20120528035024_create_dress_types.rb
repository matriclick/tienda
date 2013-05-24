class CreateDressTypes < ActiveRecord::Migration
  def change
    unless DressType.table_exists?
      create_table :dress_types do |t|
        t.string :name
        t.text :description
        t.timestamps
      end
    end
  end
end
