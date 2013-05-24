class Opportunity < ActiveRecord::Base
  belongs_to :supplier_account
  has_many :opportunity_images, :dependent => :destroy

  extend FriendlyId
  friendly_id :title, use: :slugged
  
  has_attached_file :main_image, :styles => {
                 :thumb => "100x100>",
                 :smaller => "120x90>",
                 :small => "220x150>",
                 :tiny => "40x40>",
             		 :regular => "300x200>"
         }, :whiny => false

 has_attached_file :side_image, :styles => {
                 :smaller => "50x75>",
                 :small => "100x150>",
             		 :regular => "400x500>"
         }, :whiny => false
                
  accepts_nested_attributes_for :opportunity_images, :reject_if => proc { |a| a[:opportunity_image].blank? }, :allow_destroy => true
  
end
