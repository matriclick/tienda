class AddVideoTypeToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :video_type, :string
  end
end
