class Contestant < ActiveRecord::Base
  extend FriendlyId
  
  friendly_id :name, use: :slugged

  belongs_to :contest
  belongs_to :user
  
  has_many :contestant_images, :dependent => :destroy
  has_many :contest_votes, :dependent => :destroy
  
	accepts_nested_attributes_for :contestant_images, :reject_if => proc { |a| a[:image].blank? }, :allow_destroy => true
end
