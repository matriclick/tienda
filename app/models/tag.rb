class Tag < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :dresses
  belongs_to :tag_type
end
