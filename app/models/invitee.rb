class Invitee < ActiveRecord::Base
  belongs_to :invitee_group
  belongs_to :user_account
  belongs_to :age
  belongs_to :address
  belongs_to :status
  belongs_to :gender
  belongs_to :couple
	belongs_to :invitee_host
	belongs_to :invitee_role
	belongs_to :invitation
  validates_presence_of :name,:lastname_p
  # validates_uniqueness_of :name, :scope => [:lastname_p, :lastname_m, :user_account_id], :message => I18n.t('duplicate_error')
  accepts_nested_attributes_for :address
  
  def self.search(query)
    words = query.to_s.strip.split
    
    words.inject(scoped) do |combined_scope, word|
      wrd = "%#{word}%"
      combined_scope.where("name LIKE ? or lastname_p LIKE ? or lastname_m LIKE ? or email LIKE ? ",wrd,wrd,wrd,wrd)
    end
  end
end