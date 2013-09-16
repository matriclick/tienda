class DressStatus < ActiveRecord::Base
  has_many :dresses, :dependent => :destroy
end
