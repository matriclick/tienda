class NewHiddenIndustryCategory < ActiveRecord::Migration
  def up
    IndustryCategory.create(  :name => 'Corredoras e Inmobiliarias',
                              :industry_category_type_id => 1,
                              :budget_priority => 999,
                              :position => 999
                              )
  end

  def down
    ic = IndustryCategory.find_by_name('Corredoras e Inmobiliarias')
    if !ic.blank?
      ic.destroy
    end
  end
end
