class CopyAddressFieldToAddressesTable < ActiveRecord::Migration

  def self.up
    count = 0
    supplier_accounts = SupplierAccount.all
    supplier_accounts.each do |supplier_account|
      a = Address.create(:street => supplier_account.addressf)
      supplier_account.address_id = a.id
      
      #INICIO: Esto es para no violar restricciones del modelo supplier_account, ya que si se viola una restricción, no se modifica el registro en la base de datos.
        if supplier_account.corporate_name.nil?
          supplier_account.corporate_name = 'No Disponible ' + count.to_s
        end
        if supplier_account.fantasy_name.nil?
          supplier_account.fantasy_name = 'no_disponible'
        end
        if supplier_account.phone_number.nil?
          supplier_account.phone_number = '00000000'
        end
        if supplier_account.public_url.nil? or supplier_account.public_url =~ /\W/
          supplier_account.public_url = 'no_disponible_' + count.to_s
        end
        if supplier_account.image_content_type.nil?
          supplier_account.image_content_type = 'image/jpeg'
        end
        if supplier_account.image_file_size.nil?
          supplier_account.image_file_size = 1
        end     
        if !supplier_account.industry_categories.exists?
          default_industry_category = IndustryCategory.first
          supplier_account.industry_categories << default_industry_category
        end      
        for p in supplier_account.products
          if supplier_account.industry_categories.find_all_by_id(p.industry_category_id).length == 0
            p.destroy
          end             
        end
        for s in supplier_account.services
          if supplier_account.industry_categories.find_all_by_id(s.industry_category_id).length == 0   
            s.destroy
          end
        end
        count = count + 1
      #FIN
      
      supplier_account.save #Si alguna restricción del modelo supplier_account es violada, esta línea no tiene efecto.
    end
  end
  
  def self.down
  end

end
