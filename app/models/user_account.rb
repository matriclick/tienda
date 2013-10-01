class UserAccount < ActiveRecord::Base
  include CountryMethods

  after_create :set_country_id_with_locale

  belongs_to :country
	has_many :users, :dependent => :destroy
  
end
