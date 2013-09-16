class RemoveAdminTestType < ActiveRecord::Migration
  def up
    DressStatus.find_by_name('Admin-Test').destroy
  end

  def down
  end
end
