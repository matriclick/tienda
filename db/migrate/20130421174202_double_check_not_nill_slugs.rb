class DoubleCheckNotNillSlugs < ActiveRecord::Migration
  def up
    Dress.where(:slug => nil).each do |d|
      d.update_attribute :slug, d.dress_types.first.name+'-'+d.id.to_s
    end
  end

  def down
  end
end
