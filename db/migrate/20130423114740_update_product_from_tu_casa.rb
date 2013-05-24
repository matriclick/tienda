class UpdateProductFromTuCasa < ActiveRecord::Migration
  def up
    dt = DressType.find_by_name('tu casa - cubrecamas')
    dtNew = DressType.find_by_name('tu-casa-dormitorio-cubrecamas')
    
    if !dt.nil? and !dtNew.nil?
      dt.dresses.each do |d|
        d.dress_types.clear
        d.dress_types << dtNew
        d.save
      end
      dt.destroy
    end
  end

  def down
  end
end
