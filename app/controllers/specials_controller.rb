# encoding: UTF-8
class SpecialsController < ApplicationController

  def vina
    @title_content = ' - Todo para tu Matrimonio en Viña del Mar'
    @supplier_accounts = []
    vina = Commune.where(:name => 'Viña del Mar').first
    vina_addresses = Address.where("commune_id = #{vina.id}")

    vina_addresses.each do |vina_address|
      if !vina_address.supplier_account.nil?
        @supplier_accounts << vina_address.supplier_account if vina_address.supplier_account.is_approved?
      end
    end    
    @industry_categories = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).order(:position)
  end
  
  def honeymoon
    @title_content = ' - Luna de Miel'
    @supplier_account = SupplierAccount.find(905) # 905 En Producción: Travelite
  end
  
end
