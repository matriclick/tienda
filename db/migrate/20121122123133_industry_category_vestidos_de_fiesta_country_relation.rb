class IndustryCategoryVestidosDeFiestaCountryRelation < ActiveRecord::Migration
  def change
    chile = Country.find_by_url_path('chile')
    vestidos_de_fiesta = IndustryCategory.find_by_name('vestidos_de_fiesta')

    if !chile.blank? and !vestidos_de_fiesta.blank?
      vestidos_de_fiesta.countries << chile
    end
  end
end
