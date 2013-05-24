=begin
Los proveedores con descuento son:
- Spiros: 7,5%
- Kubikled: 7,5%
- Canto Eventos: 15%
- Ella la Bella: 7,5%
- Magic Box: 15%
- Ofelia: 7,5%
- Bernardita Cerveró: 15%
- Claudia Valenzuela (Tocados novias): 15%
- Francisca Cornejo: 15%
- Francisco Moyano: 15%
- De patio moda: 15%
- Canticorus: 15%
=end

class MayDiscounts < ActiveRecord::Migration
	def up
		change_column :services, :discount, :decimal
		change_column :products, :discount, :decimal
			
		providers_discount = Array.new
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%spiros%"').first, 7.5]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%kubik%led%"').first, 7.5]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%canto%eventos%"').first, 15]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%ellalabella%"').first, 7.5]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%magic%box%"').first, 15]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%ofelia%"').first, 7.5]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%bernardita%cervero%"').first, 15]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%tocados%para%novias%"').first, 15]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%francisca%cornejo%"').first, 15]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%francisco%moyano%"').first, 15]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%de%patio%"').first, 15]
		providers_discount << Array[SupplierAccount.where('fantasy_name like "%canticorus%"').first, 15]
			
		providers_discount.each do |p|
			if !p[0].nil?
				if p[0].services.count > 0
					p[0].services.each do |service|
						service.update_attribute :discount, p[1]
					end
				end
				if p[0].products.count > 0
					p[0].products.each do |product|
						product.update_attribute :discount, p[1]
					end
				end
			end
		end
	end

	def down
	end
end
