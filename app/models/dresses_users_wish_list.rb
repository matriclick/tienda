class DressesUsersWishList < ActiveRecord::Base
  belongs_to :user
  belongs_to :dress
end
