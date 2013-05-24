class DropTableTransporteNoviosIfExists < ActiveRecord::Migration
  def up
    if !IndustryCategory.find_by_name("Transporte novios").nil?
      IndustryCategory.find_by_name("Transporte novios").destroy
    end
  end

  def down
  end
end
