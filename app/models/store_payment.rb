class StorePayment < ActiveRecord::Base
  belongs_to :supplier_account
  has_and_belongs_to_many :shopping_cart_items
end
