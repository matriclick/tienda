class Album < ActiveRecord::Base
  belongs_to :supplier_account
  belongs_to :industry_category
  has_many :album_photos, :dependent => :destroy, :validate => true
  
  validates :name, :industry_category_id, :presence => true
  
  accepts_nested_attributes_for :album_photos, :allow_destroy => true
  
  def self.visible
    where(:visible => true)
  end
  
  def visible?
    return self.visible
  end
  
end
