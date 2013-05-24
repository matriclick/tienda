class AddStandarSizes < ActiveRecord::Migration
  def up
    dts = DressType.all
    dts.each do |dt|
      ['XS', 'S', 'M', 'L', 'XL'].each do |name|
        Size.create(:name => name, :dress_type_id => dt.id)
      end
    end
  end

  def down
  end
end
