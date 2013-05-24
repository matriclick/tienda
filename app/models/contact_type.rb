class ContactType < ActiveRecord::Base
	has_many :supplier_contacts
end
