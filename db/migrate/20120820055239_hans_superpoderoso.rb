class HansSuperpoderoso < ActiveRecord::Migration
  def up
    Privilege.create(:name => 'Matriclickers', :description => 'Puede administrar Matriclickers')
    
    matriclicker = Matriclicker.find_by_name 'Hans Hanckes'
    if !matriclicker.nil?
      matriclicker.privileges << Privilege.find_by_name('Matriclickers')
      matriclicker.save
    end
  end

  def down
  end
end
