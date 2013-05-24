class CreateDressTypesSizes < ActiveRecord::Migration
  def up
    create_table :dress_types_sizes, :id => false do |t|
      t.integer :dress_type_id
      t.integer :size_id
    end
    dress_types = DressType.all
    sizes = Size.where('id in (1, 2, 3, 4, 5)') # id between 1 and 5: XS, S, M, L, XL
    dress_types.each do |dress_type|
      sizes.each do |size|
        dress_type.sizes << size
      end
    end
  end

  def down
    drop_table :dress_types_sizes
  end
end
