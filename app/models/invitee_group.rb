class InviteeGroup < ActiveRecord::Base
  has_many :invitees
  belongs_to :user_account
	validates_presence_of :name
	validates_uniqueness_of :name, :scope => [:user_account_id],:message=> I18n.t('duplicate_error')
end

