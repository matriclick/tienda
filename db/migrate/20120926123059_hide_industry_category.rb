class HideIndustryCategory < ActiveRecord::Migration
  def change
    ic = IndustryCategory.find_by_name('Corredoras e Inmobiliarias')
    if !ic.nil?
      ic.hidden = true
      ic.save
    end
  end
end
