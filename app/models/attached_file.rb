class AttachedFile < ActiveRecord::Base
	belongs_to :attachable, :polymorphic => true
	
	has_attached_file :attached
	validates_attachment_size :attached, :less_than => 4.megabytes
end
