class DeleteGarbageInSizes < ActiveRecord::Migration
  def up
    sizes = Size.where('id > 5')
    sizes.each do |size|
      size.destroy
    end
    remove_column :sizes, :dress_type_id
  end
end
