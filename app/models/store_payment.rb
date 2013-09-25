class StorePayment < ActiveRecord::Base
  has_and_belongs_to_many :shopping_cart_items
end
