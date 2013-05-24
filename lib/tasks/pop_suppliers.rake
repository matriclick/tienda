# coding: utf-8
namespace :db do
	desc "Erase and fill database"
	task :pop_suppliers => :environment do
		# FGM: Fill up with some suppliers.
		# First run rake db:setup
		[Supplier, SupplierAccount, Presentation].each do |db|
			db.delete_all
		end
		
		10.times do |i|
			s = Supplier.create! email:"s#{i}@redvel.cl", password:"francois"
			s.supplier_account.update_attribute :rut, "#{i}#{i}#{i}#{i}#{i}#{i}#{i}#{i}#{i}"
			s.supplier_account.update_attribute :corporate_name, "EMPRESA #{i}"
			s.supplier_account.update_attribute :fantasy_name, "emp #{i}"
			s.supplier_account.update_attribute :phone_number, i
			s.supplier_account.update_attribute :address, "dirección nº#{i}"
			s.supplier_account.update_attribute :email, "email#{i}@email.com"
			s.supplier_account.industry_category_ids = (3 % (i+1))
			puts s.supplier_account.corporate_name + "  created"	
		end
	end
end
