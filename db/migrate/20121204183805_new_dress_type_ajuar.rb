# encoding: UTF-8
class NewDressTypeAjuar < ActiveRecord::Migration
  def up
    DressType.create(:name => 'Ajuar', :description => 'Artículos de ajuar')
  end

  def down
    ajuar_type = DressType.find_by_name('Ajuar')
    ajuar_type.destroy
  end
end
