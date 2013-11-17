class AddVideoUrlToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :video_url, :string
  end
end
