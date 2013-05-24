module SpecialsHelper

  def should_show_industry?(i)
    if industry_has_suppliers?(i) and not_all_in_sub(i)
      return true
    end
    return false
  end

  def industry_has_suppliers?(i)
    @supplier_accounts.each do |supplier_account|
      if supplier_account.industry_categories.include?(i)
        return true
      end
    end
    return false    
  end

  def not_all_in_sub(i)
    suppliers_to_check = []
    @supplier_accounts.each do |supplier_account|
      if supplier_account.industry_categories.include?(i)
        suppliers_to_check << supplier_account
      end
    end
    supplier_found = false
    suppliers_to_check.each do |supplier_to_check|
      supplier_in_sub = false
      i.sub_industry_categories.each do |si|
        if supplier_to_check.sub_industry_categories.include?(si)
          supplier_in_sub = true
        end
      end
      if !supplier_in_sub
        supplier_found = true
      end
    end
    return supplier_found
  end

  def should_show_sub_industry?(si)
    if sub_industry_has_suppliers?(si)
      return true
    end
    return false
  end

  def sub_industry_has_suppliers?(si)
    @supplier_accounts.each do |supplier_account|
      if supplier_account.sub_industry_categories.include?(si)
        return true
      end
    end
    return false    
  end

  def supplier_in_sub?(sup, i)
    i.sub_industry_categories.each do |si|
      if sup.sub_industry_categories.include?(si)
        return true
      end
    end
    return false
  end

end
