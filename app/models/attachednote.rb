class Attachednote < ActiveRecord::Base
	belongs_to :attachable, :polymorphic => true
	
	validates :attachable_type, :attachable_id, :message, :presence => true
end
