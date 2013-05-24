class Country < ActiveRecord::Base
  has_many :leads
  has_many :slider_images
  has_many :suppliers
  has_many :supplier_accounts
  has_many :posts
  has_many :users
  has_many :user_accounts
  has_and_belongs_to_many :industry_categories
  has_and_belongs_to_many :sub_industry_categories
end
