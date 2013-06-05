class DressType < ActiveRecord::Base
  has_and_belongs_to_many :dresses
  has_and_belongs_to_many :sizes
  
  def self.get_options(supplier_account)
    if supplier_account.nil?
      return DressType.all.sort_by {|dt| dt[:name]}
    else
      sa_type = supplier_account.supplier_account_type.name
      
      if ['Facebook', 'Matriclick', 'Vestidos de Novia Usados', 'Vestidos Boutique'].include?(sa_type)
        return DressType.where('name like "%Vestidos%"').sort_by {|dt| dt[:name]}
      elsif sa_type == "Ropa de Bebe"
        return DressType.where('name like "%Bebe%"').sort_by {|dt| dt[:name]}
      elsif sa_type == "Tu Casa"
        return DressType.where('name like "%Tu-Casa%"').sort_by {|dt| dt[:name]}
      elsif sa_type == "Accesorios"
        return DressType.where('name like "%Accesorios%"').sort_by {|dt| dt[:name]}
      elsif sa_type == "Zapatos"
        return DressType.where('name like "%Zapatos%"').sort_by {|dt| dt[:name]}
      elsif sa_type == "Ropa de Mujer"
        return DressType.where('name like "%Mujer%"').sort_by {|dt| dt[:name]}
      else
        return DressType.all.sort_by {|dt| dt[:name]}
      end
    end
  end
  
  def get_human_name
	  return self.name.gsub('-', ' ').capitalize
  end
  
end
