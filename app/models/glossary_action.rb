class GlossaryAction < ActiveRecord::Base
  belongs_to :user
  belongs_to :gigauser,:class_name => "Gigauser",:foreign_key => "user_id"
  belongs_to :target, :polymorphic => true
end
