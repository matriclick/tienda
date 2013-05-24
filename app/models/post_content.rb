class PostContent < ActiveRecord::Base
  belongs_to :post
  has_many :post_images, :dependent => :destroy

  accepts_nested_attributes_for :post_images, :reject_if => proc { |a| a[:photo].blank? }, :allow_destroy => true
end
