class AllDressTypeNamesToLowerCase < ActiveRecord::Migration
  def up
    DressType.all.each do |dt|
      dt.update_attribute :name, dt.name.downcase
    end
  end

  def down
  end
end
