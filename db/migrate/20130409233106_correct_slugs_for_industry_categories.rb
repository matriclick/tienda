class CorrectSlugsForIndustryCategories < ActiveRecord::Migration
  def up
    ics = IndustryCategory.all
    ics.each do |ic|
      puts ic.name.gsub(/_/,"-")
      ic.update_attribute :slug, ic.name.gsub(/_/,"-")
    end
  end

  def down
  end
end
