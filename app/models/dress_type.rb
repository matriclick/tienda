class DressType < ActiveRecord::Base
  has_and_belongs_to_many :dresses
  has_and_belongs_to_many :sizes
  
  def self.get_options(supplier_account)
    if supplier_account.nil?
      return DressType.all.sort_by {|dt| dt[:name]}
    else
      sa_type = supplier_account.supplier_account_type.name
      
      if sa_type == "Ropa de Bebe"
        return DressType.where('name like "%bebe%"').sort_by {|dt| dt[:name]}
      elsif sa_type == "Tu Casa"
        return DressType.where('name like "%tu-casa%"').sort_by {|dt| dt[:name]}
      else
        return DressType.where('name not like "%bebe%" and name not like "%tu-casa%"').sort_by {|dt| dt[:name]}
      end
    end
  end
  
  def get_human_name
	  return self.name.gsub('-', ' ').capitalize
  end
  
end
