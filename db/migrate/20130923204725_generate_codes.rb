class GenerateCodes < ActiveRecord::Migration
  def up
    Dress.all.each do |d|
      if d.code.blank?
        code_s = 'TRA'
        d.dress_type.name.split('-').each do |a|
          code_s = code_s+a[0..1].upcase
        end
        d.code = code_s+d.id.to_s
        puts d.code
        d.save
      end
    end
  end

  def down
  end
end
