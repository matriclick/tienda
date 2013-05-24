class InviteeHost < ActiveRecord::Base
  has_many :invitees
  validates_presence_of :name
end
