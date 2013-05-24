class AllSuppliersAreRegular < ActiveRecord::Migration
  def up
	regular = SupplierAccountType.find_by_name('Regular')
	if !regular.nil?
		id = regular.id
		sa = SupplierAccount.where('supplier_account_type_id is null')
		sa.each do |s|
		  s.update_attribute(:supplier_account_type_id, id)
		end
	end
  end

  def down
  end
end
