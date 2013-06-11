class DeliveryMethod < ActiveRecord::Base
  has_many :purchases
end
